import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sognora_social_login/src/provider/google.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Mock 클래스를 생성하여 GoogleSignIn의 동작을 시뮬레이션합니다.
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  group('GoogleLogin', () {
    late GoogleLogin googleLogin;
    late MockGoogleSignIn mockGoogleSignIn;

    setUp(() {
      mockGoogleSignIn = MockGoogleSignIn();
      googleLogin = GoogleLogin(googleSignIn: mockGoogleSignIn);
    });

    test('signIn 성공 시', () async {
      final mockAccount = MockGoogleSignInAccount();
      when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockAccount);

      final result = await googleLogin.signIn();
      expect(result, isNotNull); // 로그인 성공 시 null이 아닌지 확인
    });

    test('signIn 실패 시', () async {
      when(mockGoogleSignIn.signIn()).thenThrow(Exception("Login failed"));

      final result = await googleLogin.signIn();
      expect(result, isNull); // 로그인 실패 시 null 반환 확인
    });

    test('signOut 성공 시', () async {
      when(mockGoogleSignIn.signOut()).thenAnswer((_) async => null);

      await googleLogin.signOut();
      verify(mockGoogleSignIn.signOut()).called(1); // signOut 호출 확인
    });
  });
}
