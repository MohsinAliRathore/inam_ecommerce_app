import 'package:flutter/material.dart';

import '../Models/CategoryModel.dart';

class CategoryCard extends StatelessWidget {
  final Datum category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex:2,
                child: SizedBox(
                  height: 100,
                    child: Image.network('https://inamstore.devblinks.com/storage/${category.image}')),
              ),
              Expanded(
                flex:1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex:2,
                        child: Text(category.value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                              fontSize: 16
                            )),
                      ),
                      Expanded(
                        flex:2,
                          child: Text(category.description)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
