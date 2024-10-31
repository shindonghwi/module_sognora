import 'package:google_sign_in/google_sign_in.dart';

class SognoraResponse<T> {
  final int status; // 응답 코드 (예: 200, 400)
  final String msg; // 응답 메시지 (예: 성공, 실패 등)
  final T? data; // 실제 응답 데이터 (제네릭 타입으로 지정)

  SognoraResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  // GoogleSignInAccount 객체로부터 SognoraResponse 생성
  factory SognoraResponse.fromGoogle(
    GoogleSignInAccount account, {
    required int status,
    required String msg,
  }) {
    return SognoraResponse(
      status: status,
      msg: msg,
      data: {
        'id': account.id,
        'email': account.email,
        'name': account.displayName,
        'profileImageUrl': account.photoUrl,
        'rawResponse': account,
      } as T,
    );
  }
}
