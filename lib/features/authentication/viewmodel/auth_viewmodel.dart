import 'package:eired/core/global_variables.dart';
import 'package:eired/features/authentication/usecases/authenticate_user.dart';
import 'package:eired/features/todo_list/views/todo_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/snackbar_helper.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticateUserUsecase authenticateUserUsecase;
  bool isLoading = false;

  AuthViewModel({required this.authenticateUserUsecase});
  void signinWithGoogle() async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential user = await authenticateUserUsecase.signInWithGoogle();
      GlobalVariable.uid = user.user!.uid;

      isLoading = false;
      notifyListeners();
      Get.offAll(const TodoScreen());
    } catch (e) {
      ShowSnackbar.showErrorSnackbar("unable to signin with google : $e");
    }
  }
}
