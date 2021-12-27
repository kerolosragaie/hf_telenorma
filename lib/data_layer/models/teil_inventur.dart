class TeilInventur {
  String? id;
  String? kasseId;
  String? userId;
  String? shopId;
  String? bemerkung;
  String? created;
  String? modified;
  String? status;
  String? kasseDocumentId;

  TeilInventur(
      {this.id,
      this.kasseId,
      this.userId,
      this.shopId,
      this.bemerkung,
      this.created,
      this.modified,
      this.status,
      this.kasseDocumentId});

  TeilInventur.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kasseId = json['kasse_id'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    bemerkung = json['bemerkung'];
    created = json['created'];
    modified = json['modified'];
    status = json['status'];
    kasseDocumentId = json['kasse_document_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['kasse_id'] = kasseId;
    data['user_id'] = userId;
    data['shop_id'] = shopId;
    data['bemerkung'] = bemerkung;
    data['created'] = created;
    data['modified'] = modified;
    data['status'] = status;
    data['kasse_document_id'] = kasseDocumentId;
    return data;
  }
}
