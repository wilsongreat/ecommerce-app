import 'package:ecommerce/app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider.dart';
import '../../view_model/bag_view_model.dart';
import '../../widgets/empty_widget.dart';

class UserBag extends ConsumerWidget {
  const UserBag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final bagViewModel = ref.watch(bagProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Flexible(
                    child: Text(
                      "My Bag",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
              bagViewModel.productsBag.isEmpty
                  ? const Flexible(
                      child: EmptyWidget(
                        text: "No item added",
                      ),
                    )
                  : Flexible(
                      child: ListView.builder(
                        itemCount: bagViewModel.totalProducts,
                        itemBuilder: (context, index) {
                          final product = bagViewModel.productsBag[index];
                          return ListTile(
                            title: Text(product.name),
                            subtitle: Text("\$" + product.price.toString()),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                bagViewModel.removeProduct(product);
                              },
                            ),
                          );
                        },
                      ),
                    ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: \$" + bagViewModel.totalPrice.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final payment = ref.read(paymentProvider);
                        final user = ref.read(authStateChangesProvider);
                        final userBag = ref.watch(bagProvider);
                        var result = await payment.initPaymentSheet(
                            user.value!, userBag.totalPrice);
                        if (!result.isError) {
                          ref.read(databaseaprovider)!.saveOrder(
                              result.payIntentId!, userBag.productsBag);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Paymet Completed')));
                          // userBag.clearBag();
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result.message)));
                        }
                      },
                      child: const Text("Checkout"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
