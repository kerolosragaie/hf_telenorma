class Shops {
  late String id;
  late String title;
  late String street;
  late String isStore;


  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    street = json['street'];
    isStore = json['is_store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['street'] = street;
    data['is_store'] =isStore;
    return data;
  }
}