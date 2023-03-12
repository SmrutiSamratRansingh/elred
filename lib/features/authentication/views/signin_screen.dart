import 'package:eired/features/authentication/repository/auth_repository.dart';
import 'package:eired/features/authentication/usecases/authenticate_user.dart';
import 'package:eired/features/authentication/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signin extends StatelessWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => AuthViewModel(
            authenticateUserUsecase:
                AuthenticateUserUsecase(authRepository: AuthRepository()),
          )),
      child: const SigninScreen(),
    );
  }
}

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
            : ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthViewModel>().signinWithGoogle();
                },
                icon: Image.asset(
                  "assets/images/google_logo.png",
                  height: 20,
                ),
                label: const Text("Signin with Google")),
      ),
    );
  }
}
