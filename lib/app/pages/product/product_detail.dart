import 'package:ecommerce/app/models/product_model.dart';
import 'package:ecommerce/app/pages/user/user_bag.dart';
import 'package:ecommerce/app/provider.dart';
import 'package:ecommerce/app/view_model/bag_view_model.dart';
import 'package:ecommerce/app/widgets/user_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetails extends ConsumerWidget {
  final Product product;
  const ProductDetails(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bagviewModel = ref.read(bagProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            UserTopBar(
                leadingIconButton: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )),
            const SizedBox(
              height: 15.0,
            ),
            Hero(
              tag: product.name,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "My Store",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w300,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              product.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Description",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              product.description,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Price",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                Text(
                  "\$" + product.price.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                bagviewModel.addProduct(product);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserBag()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15.0)),
                child: const Center(
                  child: Text(
                    'Add to Bag',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
