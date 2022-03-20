
class Bestellung {
   String? id;
   String? kasseId;
   String? userId;
   String? shopId;
   String? kassenId;
   String? bemerkung;
   String? created;
   String? modified;
   String? status;
   String? kasseDocumentId;

  Bestellung({
     this.id,
     this.kasseId,
     this.userId,
     this.shopId,
     this.kassenId,
     this.bemerkung,
     this.created,
     this.modified,
     this.status,
     this.kasseDocumentId,
  });

  Bestellung.fromJson(Map<String, dynamic> json){
    id = json['id'];
    kasseId = json['kasse_id'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    kassenId = json['kassen_id'];
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
    _data['shop_id'] = shopId;
    _data['kassen_id'] = kassenId;
    _data['bemerkung'] = bemerkung;
    _data['created'] = created;
    _data['modified'] = modified;
    _data['status'] = status;
    _data['kasse_document_id'] = kasseDocumentId;
    return _data;
  }
}