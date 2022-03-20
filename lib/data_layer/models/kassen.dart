class Kassen {
  String? shopId;
  String? kasssName;

  Kassen({this.shopId, this.kasssName});

  Kassen.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    kasssName = json['kassse_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['kassse_name'] = this.kasssName;
    return data;
  }
}
