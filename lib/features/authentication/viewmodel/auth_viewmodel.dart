import 'package:eired/features/authentication/usecases/authenticate_user.dart';
import 'package:eired/features/todo_list/views/todo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticateUserUsecase authenticateUserUsecase;
  bool isLoading = false;

  AuthViewModel({required this.authenticateUserUsecase});
  void signinWithGoogle() async {
    isLoading = true;
    notifyListeners();
    await authenticateUserUsecase.signInWithGoogle();
    isLoading = false;
    notifyListeners();
    Get.offAll(const Todo());
  }
}
