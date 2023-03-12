import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ShowSnackbar {
  static void showErrorSnackbar(String message) {
    Get.snackbar("Alert!!", message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2));
  }
}
