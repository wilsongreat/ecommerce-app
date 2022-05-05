import 'package:ecommerce/app/service/firestore_service.dart';
import 'package:ecommerce/app/service/storage_service.dart';
import 'package:ecommerce/app/view_model/bag_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'service/payment_service.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});
final databaseaprovider = Provider<FirestoreService?>(
  (ref) {
    final auth = ref.watch(authStateChangesProvider);
    String? uid = auth.asData?.value?.uid;
    if (uid != null) {
      return FirestoreService(uid: uid);
    }
    return null;
  },
);
final addImageProvider = StateProvider<XFile?>((_) => null);
final storageProvider = Provider<StorageService?>(((ref) {
  final auth = ref.watch(authStateChangesProvider);
  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return StorageService(uid: uid);
  }
  return null;
}));

final bagProvider =
    ChangeNotifierProvider<BagViewModel>(((ref) => BagViewModel()));

final paymentProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});
