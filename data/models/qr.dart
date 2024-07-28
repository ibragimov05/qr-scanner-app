class Qr {
  final int id;
  final String data;
  final DateTime createdDate;

  Qr({
    required this.id,
    required this.data,
    required this.createdDate,
  });

  factory Qr.fromMap(Map<dynamic, dynamic> map) {
    return Qr(
      id: map['id'] ?? DateTime.now().microsecondsSinceEpoch,
      data: map['data'] ?? '',
      createdDate: map['created-date'] ?? DateTime.now(),
    );
  }

  static Map<String, dynamic> toMap(String data, [DateTime? createdDate]) {
    return {
      'id': DateTime.now().microsecondsSinceEpoch,
      'data': data,
      'created-date': createdDate ?? DateTime.now(),
    };
  }
}
