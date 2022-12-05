import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:kthp_moblie/service/product.service.dart';

class CartProvider with ChangeNotifier{

  List<Product> listCart = [];

  bool addCart(Product product_cart){
    var contain = listCart.where((element) => element.id == product_cart.id);

    if(!contain.isEmpty){
      print("add cart failed!!");
      return false;
    }
    print("add cart success!!");
    listCart.add(product_cart);
    print(listCart);
    notifyListeners();
    return true;

  }

  void removeItemCart(int index){
    listCart.removeAt(index);
    print("Remove Item");
    notifyListeners();
  }
  void removeAll(){
    listCart = [];
    print("Remove Item");
    notifyListeners();
  }
}
