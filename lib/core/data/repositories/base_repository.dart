import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/data/datasources/firestore_data_source.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/firebase_exceptions.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/platform_exceptions.dart';

abstract class BaseEntity {
  String get id;
  DateTime get createdAt;
  DateTime? get updatedAt;
}

abstract class BaseRepository<T extends BaseEntity> {
  final BaseFirestoreDataSource dataSource;

  BaseRepository({required this.dataSource});

  Future<Either<TExceptions, List<T>>> getAll();
  Future<Either<TExceptions, T?>> getById(String id);
  Future<Either<TExceptions, List<T>>> getByField(String field, dynamic value);
  Future<Either<TExceptions, void>> create(T entity);
  Future<Either<TExceptions, void>> update(String id, T entity);
  Future<Either<TExceptions, void>> delete(String id);
  Future<Either<TExceptions, void>> deleteAll(List<String> ids);
}

class BaseRepositoryImpl<T extends BaseEntity> implements BaseRepository<T> {
  @override
  final BaseFirestoreDataSource dataSource;

  final T Function(Map<String, dynamic> json) fromJson;
  final Map<String, dynamic> Function(T entity) toJson;

  BaseRepositoryImpl({
    required this.dataSource,
    required this.fromJson,
    required this.toJson,
  });

  @override
  Future<Either<TExceptions, List<T>>> getAll() async {
    try {
      final data = await dataSource.getAll();
      return Right(data.map((json) => fromJson(json)).toList());
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, T?>> getById(String id) async {
    try {
      final data = await dataSource.getById(id);
      if (data == null) return const Right(null);
      return Right(fromJson(data));
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, List<T>>> getByField(
      String field, dynamic value) async {
    try {
      final data = await dataSource.getByField(field: field, value: value);
      return Right(data.map((json) => fromJson(json)).toList());
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> create(T entity) async {
    try {
      await dataSource.create(entity.id, toJson(entity));
      return const Right(null);
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> update(String id, T entity) async {
    try {
      await dataSource.update(id, toJson(entity));
      return const Right(null);
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> delete(String id) async {
    try {
      await dataSource.delete(id);
      return const Right(null);
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> deleteAll(List<String> ids) async {
    try {
      await dataSource.deleteAll(ids);
      return const Right(null);
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }
}
