class Shops{
  late String id;
  late String kasseName;
  late String shopId;

  //Shops({required this.id, required this.kasseName, required this.shopId});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kasseName = json['kasse_name'];
    shopId = json['shop_id'];
  }
}