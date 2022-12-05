import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kthp_moblie/model/buyer.dart';
import 'package:kthp_moblie/provider/buyer_provider.dart';
import 'package:kthp_moblie/provider/cart_provider.dart';
import 'package:kthp_moblie/provider/home_provider.dart';
import 'package:kthp_moblie/provider/login_provider.dart';
import 'package:kthp_moblie/screens/pages/home.dart';
import 'package:kthp_moblie/service/product.service.dart';
import 'package:provider/provider.dart';

class Detail extends StatefulWidget {
  final Product product;
  const Detail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {


  Widget buildSizeButton({title, isSeleted}) {
    return MaterialButton(
      height: 40,
      minWidth: 40,
      elevation: 0,
      color: isSeleted ? const Color(0xff8f7fc4) : const Color(0xffe8e8e8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSeleted ? Colors.white : const Color(0xff727274),
          ),
        ),
      ),
      onPressed: () {},
    );
  }

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


  @override
  Widget build(BuildContext context) {



    void addToCart(){
      final homeProvider = Provider.of<CartProvider>(context, listen: false);
      bool checkAddToCart = homeProvider.addCart(widget.product);
      if(checkAddToCart){
        show("Add cart Item successfully!!!!");
      }else{
        show("Add cart Item failed!!!!");
      }
    }


    List<String> images = [
      '${widget.product.image}',
      '${widget.product.image}',
      '${widget.product.image}',
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  scrollPhysics: const ScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  height: double.infinity,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: images
                    .map(
                      (e) => Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffb2adca).withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10.0,
                          offset: -const Offset(0, 3),
                        )
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(e),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const MyHome(),
                                ),
                              );
                            },
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xffae9fe0),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.shopping_bag_rounded,
                                color: Color(0xffae9fe0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                            "${widget.product.productName}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff39393b),
                          ),
                        ),),
                        Text(
                          "\$${widget.product.price}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff39393b),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "${widget.product.discription}",
                      style: TextStyle(
                        color: Color(0xff979797),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Choose Size",
                          style: TextStyle(
                            color: Color(0xff979797),
                          ),
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffac9ddd),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            buildSizeButton(
                              title: "S",
                              isSeleted: false,
                            ),
                            buildSizeButton(
                              title: "M",
                              isSeleted: false,
                            ),
                            buildSizeButton(
                              title: "L",
                              isSeleted: true,
                            ),
                            buildSizeButton(
                              title: "XL",
                              isSeleted: false,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Color(0xff317aaf),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xfff19a9c),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text("${widget.product.discription}"),
                            SizedBox(
                              width: 50,
                              child: Divider(
                                  thickness: 3,
                                  color: Color(0xff6b648f)
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Delivery"),
                            SizedBox(
                              width: 50,
                              child: Divider(
                                  thickness: 3, color: Colors.transparent),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Reviews"),
                            SizedBox(
                              width: 50,
                              child: Divider(
                                thickness: 3,
                                color: Colors.transparent,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Đồ thể thao đẹp",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffb2b2b2),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Đồ thể thao đẹp",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffb2b2b2),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () async {
                          print("submit add to cart");
                          addToCart();
                        },
                        height: 66,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: 66,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff9f91cc),
                                Color(0xff8471bb),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child:  Center(
                            child: Text(
                              "Add to cart",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}