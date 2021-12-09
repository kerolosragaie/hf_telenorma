class Products {
  String? id;
  String? name;
  String? ean;
  String? article;
  String? price;
  String? purchasePrice;
  String? count;
  String? vat;
  String? categoryId;
  String? lieferant;
  String? punkteFactor;
  dynamic konnektorId;
  String? isDeleted;
  String? isGroup;
  String? includeGoods;
  String? usedGood;
  String? fixPrice;
  String? orderNumber;
  String? enableDiscount;
  String? disableActions;
  String? isExpired;
  String? itemsPerBlock;
  String? alias12;
  String? alias12Sort;
  String? alias12Name;
  String? alias4;
  String? alias4Sort;
  String? alias4Name;
  String? alias6;
  String? alias6Sort;
  String? alias6Name;
  String? alias11;
  String? alias11Sort;
  String? alias11Name;
  String? size;
  String? sizeSort;
  String? sizeName;
  String? sex;
  String? sexSort;
  String? sexName;
  String? alias8;
  String? alias8Sort;
  String? alias8Name;
  String? alias9;
  String? alias9Sort;
  String? alias9Name;
  String? color;
  String? colorSort;
  String? colorName;
  String? alias3;
  String? alias3Sort;
  String? alias3Name;
  String? alias7;
  String? alias7Sort;
  String? alias7Name;
  String? alias10;
  String? alias10Sort;
  String? alias10Name;

  Products({
    this.id,
    this.name,
    this.ean,
    this.article,
    this.price,
    this.purchasePrice,
    this.count,
    this.vat,
    this.categoryId,
    this.lieferant,
    this.punkteFactor,
    this.konnektorId,
    this.isDeleted,
    this.isGroup,
    this.includeGoods,
    this.usedGood,
    this.fixPrice,
    this.orderNumber,
    this.enableDiscount,
    this.disableActions,
    this.isExpired,
    this.itemsPerBlock,
    this.alias12,
    this.alias12Sort,
    this.alias12Name,
    this.alias4,
    this.alias4Sort,
    this.alias4Name,
    this.alias6,
    this.alias6Sort,
    this.alias6Name,
    this.alias11,
    this.alias11Sort,
    this.alias11Name,
    this.size,
    this.sizeSort,
    this.sizeName,
    this.sex,
    this.sexSort,
    this.sexName,
    this.alias8,
    this.alias8Sort,
    this.alias8Name,
    this.alias9,
    this.alias9Sort,
    this.alias9Name,
    this.color,
    this.colorSort,
    this.colorName,
    this.alias3,
    this.alias3Sort,
    this.alias3Name,
    this.alias7,
    this.alias7Sort,
    this.alias7Name,
    this.alias10,
    this.alias10Sort,
    this.alias10Name,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json['id'] as String?,
        name: json['name'] as String?,
        ean: json['ean'] as String?,
        article: json['article'] as String?,
        price: json['price'] as String?,
        purchasePrice: json['purchase_price'] as String?,
        count: json['count'] as String?,
        vat: json['vat'] as String?,
        categoryId: json['category_id'] as String?,
        lieferant: json['lieferant'] as String?,
        punkteFactor: json['punkte_factor'] as String?,
        konnektorId: json['konnektor_id'] as dynamic,
        isDeleted: json['is_deleted'] as String?,
        isGroup: json['is_group'] as String?,
        includeGoods: json['include_goods'] as String?,
        usedGood: json['used_good'] as String?,
        fixPrice: json['fix_price'] as String?,
        orderNumber: json['order_number'] as String?,
        enableDiscount: json['enable_discount'] as String?,
        disableActions: json['disable_actions'] as String?,
        isExpired: json['is_expired'] as String?,
        itemsPerBlock: json['items_per_block'] as String?,
        alias12: json['alias_12'] as String?,
        alias12Sort: json['alias_12_sort'] as String?,
        alias12Name: json['alias_12_name'] as String?,
        alias4: json['alias_4'] as String?,
        alias4Sort: json['alias_4_sort'] as String?,
        alias4Name: json['alias_4_name'] as String?,
        alias6: json['alias_6'] as String?,
        alias6Sort: json['alias_6_sort'] as String?,
        alias6Name: json['alias_6_name'] as String?,
        alias11: json['alias_11'] as String?,
        alias11Sort: json['alias_11_sort'] as String?,
        alias11Name: json['alias_11_name'] as String?,
        size: json['size'] as String?,
        sizeSort: json['size_sort'] as String?,
        sizeName: json['size_name'] as String?,
        sex: json['sex'] as String?,
        sexSort: json['sex_sort'] as String?,
        sexName: json['sex_name'] as String?,
        alias8: json['alias_8'] as String?,
        alias8Sort: json['alias_8_sort'] as String?,
        alias8Name: json['alias_8_name'] as String?,
        alias9: json['alias_9'] as String?,
        alias9Sort: json['alias_9_sort'] as String?,
        alias9Name: json['alias_9_name'] as String?,
        color: json['color'] as String?,
        colorSort: json['color_sort'] as String?,
        colorName: json['color_name'] as String?,
        alias3: json['alias_3'] as String?,
        alias3Sort: json['alias_3_sort'] as String?,
        alias3Name: json['alias_3_name'] as String?,
        alias7: json['alias_7'] as String?,
        alias7Sort: json['alias_7_sort'] as String?,
        alias7Name: json['alias_7_name'] as String?,
        alias10: json['alias_10'] as String?,
        alias10Sort: json['alias_10_sort'] as String?,
        alias10Name: json['alias_10_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ean': ean,
        'article': article,
        'price': price,
        'purchase_price': purchasePrice,
        'count': count,
        'vat': vat,
        'category_id': categoryId,
        'lieferant': lieferant,
        'punkte_factor': punkteFactor,
        'konnektor_id': konnektorId,
        'is_deleted': isDeleted,
        'is_group': isGroup,
        'include_goods': includeGoods,
        'used_good': usedGood,
        'fix_price': fixPrice,
        'order_number': orderNumber,
        'enable_discount': enableDiscount,
        'disable_actions': disableActions,
        'is_expired': isExpired,
        'items_per_block': itemsPerBlock,
        'alias_12': alias12,
        'alias_12_sort': alias12Sort,
        'alias_12_name': alias12Name,
        'alias_4': alias4,
        'alias_4_sort': alias4Sort,
        'alias_4_name': alias4Name,
        'alias_6': alias6,
        'alias_6_sort': alias6Sort,
        'alias_6_name': alias6Name,
        'alias_11': alias11,
        'alias_11_sort': alias11Sort,
        'alias_11_name': alias11Name,
        'size': size,
        'size_sort': sizeSort,
        'size_name': sizeName,
        'sex': sex,
        'sex_sort': sexSort,
        'sex_name': sexName,
        'alias_8': alias8,
        'alias_8_sort': alias8Sort,
        'alias_8_name': alias8Name,
        'alias_9': alias9,
        'alias_9_sort': alias9Sort,
        'alias_9_name': alias9Name,
        'color': color,
        'color_sort': colorSort,
        'color_name': colorName,
        'alias_3': alias3,
        'alias_3_sort': alias3Sort,
        'alias_3_name': alias3Name,
        'alias_7': alias7,
        'alias_7_sort': alias7Sort,
        'alias_7_name': alias7Name,
        'alias_10': alias10,
        'alias_10_sort': alias10Sort,
        'alias_10_name': alias10Name,
      };
}
