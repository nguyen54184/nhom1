import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kthp_moblie/model/buyer.dart';
import 'package:kthp_moblie/provider/buyer_provider.dart';
import 'package:kthp_moblie/provider/cart_provider.dart';
import 'package:kthp_moblie/provider/login_provider.dart';
import 'package:kthp_moblie/screens/widgets/Card_cart.dart';
import 'package:provider/provider.dart';
class ListItem extends StatefulWidget {
  const ListItem({Key? key}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}


class _ListItemState extends State<ListItem> {

  void GetListProducts() async{
    final authProvider = Provider.of<LoginProvider>(context, listen: false);
    final buyerProvider = Provider.of<BuyerProvider>(context, listen: false);
    await buyerProvider.getProducts(authProvider.user?.id);
  }

  @override
  void initState()  {
    super.initState();
    GetListProducts();
  }

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
                child: Center(child: Text("Shoping cart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),),
              ),
              SizedBox(height: 20,),
              Container(
                  child:
                  context.watch<BuyerProvider>().listProductOfBuyer.length == 0 ? Center(child: Text("Trống ", style: TextStyle(color: Colors.green, fontStyle:  FontStyle.italic, fontSize: 16),),):
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: context.watch<BuyerProvider>().listProductOfBuyer.length,
                      itemBuilder: (context, index){
                        return Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      child: Image(
                                        height: 80,
                                        width: 80,
                                        image: NetworkImage('${context.watch<BuyerProvider>().listProductOfBuyer[index].image}'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  SizedBox(
                                    width: size.width * 0.70,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        GestureDetector(
                                          onTap: (){
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
                                                      text: "${context.watch<BuyerProvider>().listProductOfBuyer[index].productName}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                ]),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        RichText(
                                          maxLines: 1,
                                          text: TextSpan(
                                              text: 'Price: ',
                                              style: TextStyle(
                                                  color: Colors.blueGrey.shade800,
                                                  fontSize: 13.0
                                              ),
                                              children: [
                                                TextSpan(
                                                    text:
                                                    '\$${context.watch<BuyerProvider>().listProductOfBuyer[index].price}',
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FontStyle.italic,
                                                        color: Colors.red
                                                    )),
                                              ]),
                                        ),
                                        SizedBox(height: 2,),
                                        RichText(
                                          maxLines: 1,
                                          text: TextSpan(
                                              text: 'date: ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.0,

                                              ),
                                              children: [
                                                TextSpan(
                                                    text:
                                                    '${context.watch<BuyerProvider>().listProductOfBuyer[index].createdAt}',
                                                    style: const TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                        color: Colors.grey
                                                    )),
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        );
                      }
                  ))
            ],
          )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


