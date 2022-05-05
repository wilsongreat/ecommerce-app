import 'dart:html';

import 'package:ecommerce/app/models/order.dart';
import 'package:ecommerce/app/provider.dart';
import 'package:ecommerce/app/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserOrder extends ConsumerWidget {
  const UserOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: StreamBuilder<List<Order>>(
        stream: ref.read(databaseaprovider)!.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            if (snapshot.data!.isEmpty) {
              return EmptyWidget(text: 'No Orders yet');
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  final order = snapshot.data![i];
                  final total = order.products
                      .map((e) => e.price)
                      .reduce((value, element) => value + element);
                  return Padding(
                    padding: const EdgeInsets.all(8.5),
                    child: ListTile(
                      title: Text(order.products.map((e) => e.name).join(',')),
                      subtitle: Text(order.timestamp.toString()),
                      trailing: Text('\$' + total.toString()),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
