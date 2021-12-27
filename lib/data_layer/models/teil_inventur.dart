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
    data['id'] = this.id;
    data['kasse_id'] = this.kasseId;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['bemerkung'] = this.bemerkung;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['status'] = this.status;
    data['kasse_document_id'] = this.kasseDocumentId;
    return data;
  }
}
