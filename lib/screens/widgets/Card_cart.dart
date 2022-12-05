import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kthp_moblie/model/buyer.dart';
import 'package:kthp_moblie/provider/buyer_provider.dart';
import 'package:kthp_moblie/provider/cart_provider.dart';
import 'package:kthp_moblie/provider/login_provider.dart';
import 'package:kthp_moblie/screens/pages/detail.dart';
import 'package:kthp_moblie/service/product.service.dart';
import 'package:provider/provider.dart';
class CartCard extends StatefulWidget {
  final Product product;
  final int indexItem;
  const CartCard({
    Key? key,
    required this.product,
    required this.indexItem,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {

  void show(String text){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Buy Item'),
        content: Text('${text}'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void submitBuyItem(int _indexItem){
    final authProvider = Provider.of<LoginProvider>(context, listen: false);
    final buyerProvider = Provider.of<BuyerProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    String idUser = "${authProvider.user?.id}";
    String idProduct = "${widget.product.id}";
    print(idUser);
    print(idProduct);
    Buyer newBuyer = new Buyer(idUser: idUser, idProduct: idProduct, amount: 1);

    buyerProvider.createBuyer(newBuyer).then((value) => {
      if(value){
        show("Buy Item successfully!!!!"),
        cartProvider.removeItemCart(_indexItem)
      }else{
        show("Buy Item failed!!!!")
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Card(
        elevation: 5.0,
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Detail(product: widget.product)));
                      },
                      child: Image(
                        height: 80,
                        width: 80,
                        image: NetworkImage('${widget.product.image}'),
                      ),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      width: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Detail(product: widget.product)));
                            },
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                  text: 'Name: ',
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0),
                                  children: [
                                    TextSpan(
                                        text: "${widget.product.productName}",
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.bold)),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                                text: 'Price: ',
                                style: TextStyle(
                                    color: Colors.blueGrey.shade800,
                                    fontSize: 16.0
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                      '\$${widget.product.price}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.red
                                      )),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          context.read<CartProvider>().removeItemCart(widget.indexItem);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Xóa", style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      SizedBox(height: 16,),
                      InkWell(
                        onTap: (){
                          submitBuyItem(widget.indexItem);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Mua", style: TextStyle(color: Colors.green)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}


