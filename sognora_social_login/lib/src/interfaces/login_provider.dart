import '../model/response.dart';

abstract class ILoginProvider {
  Future<SognoraResponse<Map<String, dynamic>>> signIn();  // Updated return type
  Future<void> signOut();
}
