class Goods {
  String? count;
  String? goodId;
  dynamic konnektorId;

  Goods({this.count, this.goodId, this.konnektorId});

  factory Goods.fromJson(Map<String, dynamic> json) {
    return Goods(
      count: json['count'] as String?,
      goodId: json['good_id'] as String?,
      konnektorId: json['konnektor_id'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'good_id': goodId,
      'konnektor_id': konnektorId,
    };
  }
}
