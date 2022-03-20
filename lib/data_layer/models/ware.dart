class Ware {
  String? kasseId;
  String? id;
  String? kategorieId;
  String? artikel;
  String? ean;
  String? product;
  double? vk;
  String? ek;
  double? menge;

  Ware(
      {
        this.kasseId,
        this.id,
        this.ek,
        this.kategorieId,
        this.artikel,
        this.product,
        this.vk,
        this.ean,
        this.menge,});

  Ware.fromJson(Map<String, dynamic> json) {
    artikel = json['artikel'];
    kasseId = json['kasse_id'];
    artikel = json['artikel'];
    ean = json['ean'];
    ek = json['ek'];
    product = json['product'];
    vk = double.parse(json['vk']);
    id = json['id'];
    menge = double.parse(json['menge']);
  }

}
