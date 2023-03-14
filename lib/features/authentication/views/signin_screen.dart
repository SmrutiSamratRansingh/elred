import 'package:eired/features/authentication/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authVmWatch = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        alignment: Alignment.center,
        child: authVmWatch.isLoading
            ? const CircularProgressIndicator(
                color: Colors.blue,
              )
            : SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthViewModel>().signinWithGoogle();
                    },
                    icon: Image.asset(
                      "assets/images/google_logo.png",
                      height: 20,
                    ),
                    label: const Text("Signin with Google")),
              ),
      ),
    );
  }
}
