import 'package:flutter/foundation.dart';

printDebug(value) {
  if (kDebugMode) {
    print(value.toString());
  }
}
