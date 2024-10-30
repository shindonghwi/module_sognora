import 'provider/google.dart';

class Sognora {
  static final SocialLogin socialLogin = SocialLogin();
}

class SocialLogin {
  GoogleLogin google() => GoogleLogin();  // GoogleLogin 반환하는 메서드 제공
}
