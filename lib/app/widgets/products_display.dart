import 'package:ecommerce/app/extension/string_ext.dart';
import 'package:ecommerce/app/pages/product/product_detail.dart';
import 'package:ecommerce/app/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';
import 'empty_widget.dart';

class ProductDisplay extends ConsumerWidget {
  const ProductDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Product>>(
      stream: ref.read(databaseaprovider)!.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return const EmptyWidget(text: "No products available");
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, i) {
                  final product = snapshot.data![i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetails(product)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Hero(
                                  tag: product.name,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(product.imageUrl),
                                  ))),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            product.name.capitalize(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '\$${product.price.toString()}',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
