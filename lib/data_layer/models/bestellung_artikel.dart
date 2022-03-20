
class BestellungArtikel {

  String? bestellungId;
  String? artikel;
  String? charge;
  String? kasseArtikelId;
  String? ean;
  String? product;
  String? vk;
  String? kasse;
  String? menge;
  String? created;

  BestellungArtikel({
     this.bestellungId,
     this.artikel,
     this.charge,
     this.kasseArtikelId,
     this.ean,
     this.product,
     this.vk,
     this.kasse,
     this.menge,
     this.created,
  });


  BestellungArtikel.fromJson(Map<String, dynamic> json){
    bestellungId = json['bestellung_id'];
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
    final _data = <String, dynamic>{};
    _data['bestellung_id'] = bestellungId;
    _data['artikel'] = artikel;
    _data['charge'] = charge;
    _data['kasse_artikel_id'] = kasseArtikelId;
    _data['ean'] = ean;
    _data['product'] = product;
    _data['vk'] = vk;
    _data['kasse'] = kasse;
    _data['menge'] = menge;
    _data['created'] = created;
    return _data;
  }
}