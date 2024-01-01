class Row {
  int? id;
  String? arName;
  String? enName;
  double? price;
  bool? isActive;

  Row({this.id, this.arName, this.enName, this.price, this.isActive});

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'] as int?,
        arName: json['ar_name'] as String?,
        enName: json['en_name'] as String?,
        price: json['price'] as double?,
        isActive: json['is_active'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ar_name': arName,
        'en_name': enName,
        'price': price,
        'is_active': isActive,
      };
}
