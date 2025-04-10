class SyncModel {
  final int? id;
  final String operation;
  final String tableName;
  final int recordId;
  final String payload;

  SyncModel({
    this.id,
    required this.operation,
    required this.tableName,
    required this.recordId,
    required this.payload,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'operation': operation,
      'table_name': tableName,
      'record_id': recordId,
      'payload': payload,
    };
  }

  factory SyncModel.fromMap(Map<String, dynamic> map) {
    return SyncModel(
      id: map['id'],
      operation: map['operation'],
      tableName: map['table_name'],
      recordId: map['record_id'],
      payload: map['payload'],
    );
  }
}
