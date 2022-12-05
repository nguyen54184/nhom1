class Product {
  String? id;
  String? productName;
  double? price;
  String? image;
  String? discription;
  String? createdAt;


  Product({this.id, this.productName, this.price, this.image,this.discription, this.createdAt});

  // User({this.fullName, this.username, this.password});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json['_id'] as String?,
      productName: json['productName'] as String?,
      price: json['price'] as double?,
      image: json['image'] as String?,
      discription: json['discription'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }
  //
  // Map<String, dynamic> toJson(){
  //   Map<String, dynamic> map = {
  //     'fullName': fullName,
  //     'username': username,
  //     'password': password,
  //   };
  //   return map;
  // }
}