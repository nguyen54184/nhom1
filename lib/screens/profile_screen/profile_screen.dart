import 'package:flutter/material.dart';
import 'package:kthp_moblie/constants/constants.dart';
import 'package:kthp_moblie/model/product.dart';

class ItemProductBuyer extends StatefulWidget {
  final Product product;
  const ItemProductBuyer({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ItemProductBuyer> createState() => _ItemProductBuyerState();
}

class _ItemProductBuyerState extends State<ItemProductBuyer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width *0.2,
              height: MediaQuery.of(context).size.width *0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kBorderRadius),
                child: Image.network(
                  '${widget.product.image}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width *0.70,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.product.productName}",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("price: ",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300,fontStyle: FontStyle.italic, color: Colors.grey)),
                        Text("\$${widget.product.price}",style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,fontStyle: FontStyle.italic, color: Colors.red)),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text("Date: ${widget.product.createdAt}",style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
