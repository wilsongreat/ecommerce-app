import 'package:ecommerce/app/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/user_data.dart';

class AuthWidget extends ConsumerWidget {
  final WidgetBuilder signedInBuilder;
  final WidgetBuilder nonsignedInBuilder;
  final WidgetBuilder adminSignedInBuilder;

  const AuthWidget(
      {Key? key,
      required this.signedInBuilder,
      required this.nonsignedInBuilder,
      required this.adminSignedInBuilder})
      : super(key: key);
  final adminEmail = "admin@admin.com";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    return authStateChanges.when(
        data: (user) => user != null
            ? signedInHandler(context, ref, user)
            : nonsignedInBuilder(context),
        error: (_, __) => const Scaffold(
              body: Center(
                child: Text('An error occurred'),
              ),
            ),
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ));
  }

  FutureBuilder<UserData?> signedInHandler(context, WidgetRef ref, User user) {
    final database = ref.read(databaseaprovider)!;
    final potentialUserFuture = database.getUser(user.uid);
    return FutureBuilder<UserData?>(
      future: potentialUserFuture,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final potentialUser = snapshot.data;
          if (potentialUser == null) {
            database.addUser(UserData(email: user.email ?? "", uid: user.uid));
          }
          if (user.email == adminEmail) {
            return adminSignedInBuilder(context);
          }
          return signedInBuilder(context);
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}
