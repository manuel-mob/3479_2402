class Audit {
  final int? id;
  final String? action;
  final DateTime? creation;

  Audit({
    this.id,
    this.action, 
    this.creation
    });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'action': action,
      'creation': creation?.millisecondsSinceEpoch,
    };
  }

  static Audit fromMap(Map<String, dynamic> map) {
    return Audit(
      id: map['id'] as int, // Cast to int for type safety
      action: map['action'] as String, // Cast to String for type safety
      creation: DateTime.fromMillisecondsSinceEpoch(map['creation'] as int) as DateTime, // Cast to DateTime for type safety
    );
  }

}
