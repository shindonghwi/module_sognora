import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sognora_social_login/main.dart' as app;
import 'package:sognora_social_login/src/model/message.dart';
import 'package:sognora_social_login/src/model/response.dart';
import 'package:sognora_social_login/src/provider/google.dart';
import 'constant.dart'; // 상수 파일

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // 통합 테스트 환경 초기화

  group(IntegrationTestMsg.GoogleLoginIntegrationTest, () {
    final googleLogin = GoogleLogin(); // GoogleLogin 인스턴스 생성

    testWidgets(IntegrationTestMsg.GoogleLoginTest, (WidgetTester tester) async {
      // 1. 앱을 실행하고 초기 프레임이 안정될 때까지 기다립니다.
      app.main();
      await tester.pumpAndSettle();

      // 2. Google 로그인을 시도하여 SognoraResponse를 반환받습니다.
      SognoraResponse<Map<String, dynamic>> response;
      try {
        response = await googleLogin.signIn();

        // 3. SognoraResponse의 상태와 메시지를 기준으로 성공/실패 확인
        switch (response.status) {
          case 200: // 로그인 성공
            expect(response.msg, msgGoogleLoginSuccessful);
            expect(response.data, isNotNull);
            expect(response.data!['email'], isNotEmpty);
            expect(response.data!['id'], isNotNull);
            expect(response.data!['rawResponse'], isA<GoogleSignInAccount>());
            debugPrint('$msgGoogleLoginSuccessful: ${response.data!['email']}');
            break;

          case 400: // 로그인 취소
            expect(response.msg, msgGoogleLoginCancelled);
            debugPrint(msgGoogleLoginCancelled);
            break;

          case 404: // 사용자 정보 없음
            expect(response.msg, msgUserNotFount);
            debugPrint(msgUserNotFount);
            break;

          default: // 기타 예외
            fail('$msgGoogleLoginFailed: ${response.msg}');
        }
      } catch (e) {
        fail('$msgGoogleLoginFailed: $e');
      } finally {
        // 4. 테스트 후 항상 로그아웃 수행
        await googleLogin.signOut();
      }
    });
  });
}
