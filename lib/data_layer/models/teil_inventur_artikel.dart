class TeilInventurArtikel {
  String? inventurId;
  String? artikel;
  String? charge;
  String? kasseArtikelId;
  String? ean;
  String? product;
  String? vk;
  String? kasse;
  String? menge;
  String? created;

  TeilInventurArtikel(
      {this.inventurId,
      this.artikel,
      this.charge,
      this.kasseArtikelId,
      this.ean,
      this.product,
      this.vk,
      this.kasse,
      this.menge,
      this.created});

  TeilInventurArtikel.fromJson(Map<String, dynamic> json) {
    inventurId = json['inventur_id'];
    artikel = json['artikel'];
    charge = json['charge'];
    kasseArtikelId = json['kasse_artikel_id'];
    ean = json['ean'];
    product = json['product'];
    vk = json['vk'];
    kasse = json['kasse'];
    menge = json['menge'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inventur_id'] = this.inventurId;
    data['artikel'] = this.artikel;
    data['charge'] = this.charge;
    data['kasse_artikel_id'] = this.kasseArtikelId;
    data['ean'] = this.ean;
    data['product'] = this.product;
    data['vk'] = this.vk;
    data['kasse'] = this.kasse;
    data['menge'] = this.menge;
    data['created'] = this.created;
    return data;
  }
}
