// lib/src/providers/google.dart
import '../interfaces/login_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin implements ILoginProvider {
  final GoogleSignIn googleSignIn;

  GoogleLogin({GoogleSignIn? googleSignIn})
      : googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<GoogleSignInAccount?> signIn() async {
    try {
      return await googleSignIn.signIn();  // GoogleSignInAccount 객체 반환
    } catch (error) {
      print("Google sign-in failed: $error");
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
  }
}
