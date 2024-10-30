abstract class ILoginProvider {
  Future<void> signIn();
  Future<void> signOut();
}
