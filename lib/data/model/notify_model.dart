class NotifyModel {
  bool count;

  NotifyModel({
    required this.count,
  });

  NotifyModel copWith({
    bool? count,
  }) =>
      NotifyModel(
        count: count ?? this.count,
      );

  factory NotifyModel.fromJson(Map<String, dynamic> jsonData) {
    return NotifyModel(
      count: jsonData['count'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
    };
  }

  @override
  String toString() {
    return '''
      count: $count,
      
      ''';
  }
}
