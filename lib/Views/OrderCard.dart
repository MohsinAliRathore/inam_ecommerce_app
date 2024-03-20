import 'package:flutter/material.dart';
import '../Models/OrdersModel.dart';

class OrderCard extends StatelessWidget {
  final Datum order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text: 'Total Price: ',style: TextStyle(fontWeight: FontWeight.bold),),
                  TextSpan(
                    text: '${order.total} Rs',
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text: 'Total Quantity: ',style: TextStyle(fontWeight: FontWeight.bold),),
                  TextSpan(
                    text: '${order.qty}',
                  ),
                ],
              ),
            ),
            Divider(),
            const SizedBox(height: 16.0),
            Text(
              'Order Details:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            for (final detail in order.orderDetails)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Product Name: ',style: TextStyle(fontWeight: FontWeight.bold),),
                        TextSpan(
                          text: '${detail.productName}',
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Price: ',style: TextStyle(fontWeight: FontWeight.bold),),
                        TextSpan(
                          text: '${detail.productPrice} Rs',
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Quantity: ',style: TextStyle(fontWeight: FontWeight.bold),),
                        TextSpan(
                          text: '${detail.productQty}',
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(text: 'Total: ',style: TextStyle(fontWeight: FontWeight.bold),),
                        TextSpan(
                          text: '${detail.total} Rs',

                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  const SizedBox(height: 8.0),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
