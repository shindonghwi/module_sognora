// integration_test/google_login_integration_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sognora_social_login/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Google sign-in integration test', (WidgetTester tester) async {
    // 앱 실행
    app.main();
    await tester.pumpAndSettle();

    // Google 로그인 버튼을 찾습니다.
    final googleSignInButton = find.text('Sign in with Google');
    expect(googleSignInButton, findsOneWidget);

    // 로그인 버튼 클릭
    await tester.tap(googleSignInButton);
    await tester.pumpAndSettle();

    // 로그인 성공 후 표시될 결과 확인
    final successText = find.text('Login Successful');
    expect(successText, findsOneWidget); // 이제 찾을 수 있어야 합니다.
  });
}
