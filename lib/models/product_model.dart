class ProductModel {
  String? sId;
  String? name;
  String? description;
  String? img;
  num? price;
  String? createdTime;
  bool? isActive;
  int? iV;

  ProductModel(
      {this.sId,
        this.name,
        this.description,
        this.img,
        this.price,
        this.createdTime,
        this.isActive,
        this.iV});

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
    price = json['price'];
    createdTime = json['createdTime'];
    isActive = json['isActive'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['img'] = img;
    data['price'] = price;
    return data;
  }
}