class Shop {
  String? kasseId;
  String? id;
  String? title;

  Shop({this.kasseId, this.id, this.title});

  Shop.fromJson(Map<String, dynamic> json) {
    kasseId = json['kasse_id'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kasse_id'] = this.kasseId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
