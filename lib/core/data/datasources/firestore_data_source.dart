import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreCallable {
  FirebaseFirestore get firestore;
}

class FirestoreService implements FirestoreCallable {
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  @override
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}

abstract class BaseFirestoreDataSource {
  final String collectionName;
  final FirestoreCallable _firestoreService;

  BaseFirestoreDataSource({
    required this.collectionName,
    FirestoreCallable? firestoreService,
  }) : _firestoreService = firestoreService ?? FirestoreService();

  FirebaseFirestore get _firestore => _firestoreService.firestore;
  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(collectionName);

  Future<List<Map<String, dynamic>>> getAll({
    String? orderBy,
    bool descending = false,
  }) async {
    Query<Map<String, dynamic>> query = _collection;
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }
    final snapshot = await query.get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    final doc = await _collection.doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data();
    if (data == null) return {'id': doc.id};
    return {'id': doc.id, ...data};
  }

  Future<List<Map<String, dynamic>>> getByField({
    required String field,
    required dynamic value,
  }) async {
    final snapshot = await _collection.where(field, isEqualTo: value).get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  Future<List<Map<String, dynamic>>> getByFieldList({
    required String field,
    required List<dynamic> values,
  }) async {
    if (values.isEmpty) return [];
    final snapshot = await _collection.where(field, whereIn: values).get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  Future<void> create(String id, Map<String, dynamic> data) async {
    await _collection.doc(id).set(data);
  }

  Future<String> createWithAutoId(Map<String, dynamic> data) async {
    final docRef = await _collection.add(data);
    return docRef.id;
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _collection.doc(id).update(data);
  }

  Future<void> delete(String id) async {
    await _collection.doc(id).delete();
  }

  Future<void> deleteAll(List<String> ids) async {
    final batch = _firestore.batch();
    for (final id in ids) {
      batch.delete(_collection.doc(id));
    }
    await batch.commit();
  }
}
