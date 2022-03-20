
class Umlagerung {
  String? id;
  String? kasseId;
  String? userId;
  String? vonShopId;
  String? zuShopId;
  String? bemerkung;
  String? created;
  String? modified;
  String? status;
  String? kasseDocumentId;
  Umlagerung({
    this.id,
    this.kasseId,
    this.userId,
    this.vonShopId,
    this.zuShopId,
    this.bemerkung,
    this.created,
    this.modified,
    this.status,
    this.kasseDocumentId,
  });


  Umlagerung.fromJson(Map<String, dynamic> json){
    id = json['id'];
    kasseId = json['kasse_id'];
    userId = json['user_id'];
    vonShopId = json['von_shop_id'];
    zuShopId = json['zu_shop_id'];
    bemerkung = json['bemerkung'];
    created = json['created'];
    modified = json['modified'];
    status = json['status'];
    kasseDocumentId = json['kasse_document_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kasse_id'] = kasseId;
    _data['user_id'] = userId;
    _data['von_shop_id'] = vonShopId;
    _data['zu_shop_id'] = zuShopId;
    _data['bemerkung'] = bemerkung;
    _data['created'] = created;
    _data['modified'] = modified;
    _data['status'] = status;
    _data['kasse_document_id'] = kasseDocumentId;
    return _data;
  }
}
