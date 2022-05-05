import 'package:ecommerce/app/provider.dart';
import 'package:ecommerce/app/widgets/product_banner.dart';
import 'package:ecommerce/app/widgets/products_display.dart';
import 'package:ecommerce/app/widgets/user_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHome extends ConsumerWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserTopBar(
                  leadingIconButton: IconButton(
                      onPressed: () => ref.read(firebaseAuthProvider).signOut(),
                      icon: const Icon(Icons.logout_outlined))),
              const SizedBox(
                height: 20,
              ),
              const ProductBanner(),
              const Text(
                "Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text("View all of our products",
                  style: TextStyle(fontSize: 12)),
              const Flexible(child: ProductDisplay())
            ],
          ),
        ),
      ),
    );
  }
}
