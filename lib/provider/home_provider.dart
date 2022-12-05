import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:kthp_moblie/service/product.service.dart';

class HomeProvider with ChangeNotifier{
  List<Product> listProduct = [];

  String textSearch = "";

  List<Product> getListProducts(){
    if(textSearch.isEmpty){
      return listProduct;
    }
    return listProduct;
  }

  Future getProducts() async{
    final dio = Dio(); // Provide a dio instance
    dio.options.headers["Demo-Header"] = "demo header"; // config your dio headers globally
    final client = RestProduct(dio);
    await client.getProducts().then((it) => {
      // print(it),
      listProduct = it
    });

    notifyListeners();
    print(listProduct[0].productName);
    print(listProduct[1].productName);

    if(listProduct.length == 0){
      return true;
    }else{
      return false;
    }
  }

}
