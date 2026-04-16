abstract class BaseModel<T> {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const BaseModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson();

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  static Map<String, dynamic> baseToJson({
    required String id,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static ({String id, DateTime createdAt, DateTime? updatedAt}) baseFromJson(Map<String, dynamic> json) {
    return (
      id: json['id'] as String? ?? '',
      createdAt: _parseDate(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? _parseDate(json['updatedAt']) : null,
    );
  }

  T copyWithId(String newId);
}
