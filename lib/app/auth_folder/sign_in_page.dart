import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providerConfigs: const [EmailProviderConfiguration()],
      footerBuilder: (context, _) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'By signing in you agree to the terms and conditions',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
      // ignore: avoid_types_as_parameter_names
      headerBuilder: (context, _, double) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            "Welcome back \n login to resume shopping",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
