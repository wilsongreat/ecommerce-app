import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/app/models/order.dart';
import 'package:ecommerce/app/models/product_model.dart';
import 'package:ecommerce/app/models/user_data.dart';

class FirestoreService {
  final String uid;

  FirestoreService({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addProduct(Product product) async {
    final docId = firestore.collection('products').doc().id;
    await firestore.collection('products').doc(docId).set(product.toMap(docId));
    // .add(product.toMap())
    // .then((value) => print(value))
    // .catchError((onError) => print('Error'));
  }

  Stream<List<Product>> getProducts() {
    return firestore.collection('products').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
            final d = doc.data();
            return Product.fromMap(d);
          }).toList(),
        );
  }

  Future<void> deleteProduct(String id) async {
    return await firestore.collection('products').doc(id).delete();
  }

  Future<void> addUser(UserData user) async {
    await firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    //retrieving the user id
    final doc = await firestore.collection('users').doc(uid).get();
    //checking if user exist then retrieving the data of the user if true
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }

  Future<void> saveOrder(String confirmationId, List<Product> products) async {
// Save the order in the orders collection of the user
    await firestore.collection("users").doc(uid).collection("orders").add({
      'confirmationId': confirmationId,
      'products':
          products.map((product) => product.toMap(product.prodId)).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    });
// Save the order on an outer collection for the admin / user depending on your design decision.
    await firestore.collection("orders").doc(confirmationId).set({
      'confirmationId': confirmationId,
      'products':
          products.map((product) => product.toMap(product.prodId)).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

// get the orders the users
  Stream<List<Order>> getOrders() {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }
}
