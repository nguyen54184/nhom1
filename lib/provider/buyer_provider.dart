import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:kthp_moblie/model/buyer.dart';
import 'package:kthp_moblie/service/buyer.service.dart';

import '../model/product.dart';

class BuyerProvider with ChangeNotifier{
  List<Product> listProductOfBuyer = [];

  Future createBuyer(Buyer newBuyer) async{
    bool status = false;
    final dio = Dio(); // Provide a dio instance
    dio.options.headers["Demo-Header"] =
    "demo header"; // config your dio headers globally
    final client = RestBuyer(dio);
    await client
        .createBuyer(newBuyer)
        .then((it)=>{
          status = it.status as bool,
          print(it.buyer?.idUser),
        });
    notifyListeners();
    return status;
  }


  Future getProducts(id) async{
    final dio = Dio(); // Provide a dio instance
    dio.options.headers["Demo-Header"] = "demo header"; // config your dio headers globally
    final client = RestBuyer(dio);
    await client.getBuyers(id).then((it) => {
      print("Buyer: "),
      print(it[0].image),
      print("image"),
      print(it[0].productName),

      listProductOfBuyer = it,
      // listProducts = it as List<Product>,
      // listProduct = it.cast<Product>()
    });

    print(listProductOfBuyer);
    notifyListeners();

    if(listProductOfBuyer.length == 0){
      print(listProductOfBuyer);
      return false;
    }else{
      print(listProductOfBuyer);
      return true;
    }

  }

}
