import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kthp_moblie/provider/cart_provider.dart';
import 'package:kthp_moblie/screens/widgets/Card_cart.dart';
import 'package:provider/provider.dart';
class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width * 1,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.green
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Center(child: Text("Shoping cart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),),
                    Padding(
                      padding: EdgeInsets.only(right: 10, top: 10),
                      child: Container(
                        height: 55,
                        width: 40,
                        child: Stack(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.shopping_cart),
                              color: Colors.white,
                            ),
                            Align(
                              alignment: AlignmentDirectional.topEnd, // <-- SEE HERE
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                child: Center(child: Text("${context.watch<CartProvider>().listCart.length}", style: TextStyle(color: Colors.white),),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                  child: context.watch<CartProvider>().listCart.length == 0 ? Center(child: Text("Giỏ hàng trống! vui lòng thêm vào ...", style: TextStyle(color: Colors.green, fontStyle:  FontStyle.italic, fontSize: 16),),):

                  ListView.builder(
                  shrinkWrap: true,
                  itemCount: context.watch<CartProvider>().listCart.length,
                  itemBuilder: (context, index){
                    return CartCard(product: context.watch<CartProvider>().listCart[index], indexItem: index);
                  }
              ))
            ],
          )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


