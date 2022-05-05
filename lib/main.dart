import 'package:ecommerce/app/auth_folder/admin_home.dart';
import 'package:ecommerce/app/auth_folder/sign_in_page.dart';
import 'package:ecommerce/app/auth_widget.dart';
import 'package:ecommerce/app/pages/user/user_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = "pk_test_KegXIQBcrducTvLIyVzrbw8n00Xih2mAHm";
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(
              primary: Colors.orange, seedColor: Colors.orange)),
      home: AuthWidget(
          signedInBuilder: (context) => const UserHome(),
          nonsignedInBuilder: (context) => const SignInPage(),
          adminSignedInBuilder: (context) => const AdminHome()),
    );
  }
}
