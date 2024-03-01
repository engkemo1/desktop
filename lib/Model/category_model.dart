class CategoryModel {
  String? type;
  var price;
  var quantity;
  String? sId;
  int? iV;

  CategoryModel({this.type, this.price, this.quantity, this.sId, this.iV});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'];
    quantity = json['quantity'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
