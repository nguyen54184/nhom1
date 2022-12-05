
class Buyer {
  String? idUser;
  String? idProduct;
  int? amount;

  Buyer({this.idUser, this.idProduct, this.amount});

  factory Buyer.fromJson(Map<String, dynamic> json){
    return Buyer(
      idUser: json['idUser'] as String?,
      idProduct: json['idProduct'] as String?,
      amount: json['amount'] as int?,
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      'idUser': idUser,
      'idProduct': idProduct,
      'amount': amount,
    };
    return map;
  }
}
