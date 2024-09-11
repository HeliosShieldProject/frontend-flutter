Future<SignUpStatus> signUp(BuildContext context,
    {required String email, required String password}) async {
  User user = await _createUser(email: email, password: password);

  final Map<String, dynamic> response;

  try {
    response = await Server.signUp(
      user: user,
    );
  } catch (e) {
    print(e);
    return SignUpStatus.failed;
  }

  if (response["data"] is SignUpStatus) {
    return response["data"];
  } else {
    if (context.mounted) {
      AppUser.update(
        context,
        user
          ..jwtToken = response["data"]["access_token"]
          ..jwtRefreshToken = response["data"]["refresh_token"],
      );
      return SignUpStatus.success;
    }
    return SignUpStatus.failed;
  }
}
