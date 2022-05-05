import 'package:ecommerce/app/models/product_model.dart';
import 'package:ecommerce/app/pages/admin/admin_add_product.dart';
import 'package:ecommerce/app/provider.dart';
import 'package:ecommerce/app/utils/snackbars.dart';
import 'package:ecommerce/app/widgets/project_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AdminHome extends ConsumerWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Page"),
        actions: [
          IconButton(
              onPressed: () => ref.read(firebaseAuthProvider).signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: ref.read(databaseaprovider)!.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text("No products yet..."),
                  Lottie.network(
                      'https://assets9.lottiefiles.com/temp/lf20_Celp8h.json',
                      width: 200,
                      repeat: false)
                ]),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    final product = snapshot.data![i];
                    return Padding(
                      padding: const EdgeInsets.all(8.5),
                      child: ProductListTile(
                          product: product,
                          onDelete: () async {
                            openIconSnackBar(
                                context,
                                "Deleting item....",
                                const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ));
                            await ref
                                .read(databaseaprovider)!
                                .deleteProduct(product.prodId!);
                          }),
                    );
                  });
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AdminAddProductPage())),
      ),
    );
  }
}
