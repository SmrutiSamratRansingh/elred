import 'package:eired/features/authentication/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticateUserUsecase {
  final AuthRepository authRepository;
  AuthenticateUserUsecase({required this.authRepository});
  Future<UserCredential> signInWithGoogle() async {
    try {
      return await authRepository.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }
}
