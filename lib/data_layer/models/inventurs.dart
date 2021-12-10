import 'package:hf/data_layer/models/goods.dart';

class Inventurs {
  String? id;
  String? createDate;
  String? finishDate;
  String? shopId;
  String? supplierId;
  String? adminId;
  String? status;
  String? comment;
  String? type;
  String? jsonData;
  dynamic konnektorId;
  String? modifiedAt;
  List<Goods>? goods;

  Inventurs({
    this.id,
    this.createDate,
    this.finishDate,
    this.shopId,
    this.supplierId,
    this.adminId,
    this.status,
    this.comment,
    this.type,
    this.jsonData,
    this.konnektorId,
    this.modifiedAt,
    this.goods,
  });

  factory Inventurs.fromJson(Map<String, dynamic> json) {
    return Inventurs(
      id: json['id'] as String?,
      createDate: json['create_date'] as String?,
      finishDate: json['finish_date'] as String?,
      shopId: json['shop_id'] as String?,
      supplierId: json['supplier_id'] as String?,
      adminId: json['admin_id'] as String?,
      status: json['status'] as String?,
      comment: json['comment'] as String?,
      type: json['type'] as String?,
      jsonData: json['json_data'] as String?,
      konnektorId: json['konnektor_id'] as dynamic,
      modifiedAt: json['modified_at'] as String?,
      goods: (json['goods'] as List<dynamic>?)
          ?.map((e) => Goods.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'create_date': createDate,
      'finish_date': finishDate,
      'shop_id': shopId,
      'supplier_id': supplierId,
      'admin_id': adminId,
      'status': status,
      'comment': comment,
      'type': type,
      'json_data': jsonData,
      'konnektor_id': konnektorId,
      'modified_at': modifiedAt,
      'goods': goods?.map((e) => e.toJson()).toList(),
    };
  }
}
