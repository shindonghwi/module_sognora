import 'package:sognora_social_login/src/model/message.dart';
import '../interfaces/login_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/response.dart';

class GoogleLogin implements ILoginProvider {
  GoogleLogin();

  @override
  Future<SognoraResponse<Map<String, dynamic>>> signIn() async {
    try {
      final account = await GoogleSignIn().signIn();
      // 사용자가 로그인을 취소한 경우
      if (account == null) {
        return SognoraResponse(status: 400, msg: msgGoogleLoginCancelled, data: null);
      }

      // 로그인 성공했으나 사용자 정보가 없을 경우
      if (account.email.isEmpty || account.id.isEmpty) {
        return SognoraResponse(status: 404, msg: msgUserNotFount, data: null);
      }

      // Google 인증 정보를 받아옵니다.
      final GoogleSignInAuthentication googleAuth = await account.authentication;

      // idToken이 없는 경우 사용자 정보 없음으로 판단
      if (googleAuth.idToken == null || googleAuth.idToken!.isEmpty) {
        return SognoraResponse(status: 404, msg: msgUserNotFount, data: null);
      }

      // 로그인 성공, SognoraResponse 반환
      return SognoraResponse.fromGoogle(account, status: 200, msg: msgGoogleLoginSuccessful);
    } catch (error) {
      // 로그인 실패 시 상태 코드와 메시지를 포함하여 반환
      return SognoraResponse(status: 500, msg: "$msgGoogleLoginFailed: $error", data: null);
    }
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
  }
}
