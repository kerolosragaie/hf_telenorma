class Kasses {
  String? id;
  String? kasseName;
  String? shopId;

  Kasses({this.id, this.kasseName, this.shopId});

  factory Kasses.fromJson(Map<String, dynamic> json) {
    return Kasses(
      id: json['id'] as String?,
      kasseName: json['kasse_name'] as String?,
      shopId: json['shop_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kasse_name': kasseName,
      'shop_id': shopId,
    };
  }
}
