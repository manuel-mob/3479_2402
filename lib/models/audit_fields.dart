class AuditFields {
  static const String tableName = 'audit';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = '_id';
  static const String action = 'action';
  static const String createdTime = 'created_time';
}