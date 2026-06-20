import 'package:app/common/http_client.dart';
import 'package:app/data/auth_info.dart';
import 'package:app/data/data_source/auth_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(
  dataSource: AuthRemoteDataSource(dio: httpClient),
);

abstract class IAuthRepository {
  Future<void> login(String username, String passwpord);
  Future<void> signUp(String username, String passwpord);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  final ValueNotifier<AuthInfo?> authChangeNotifire = ValueNotifier(null);
  final IAuthDataSource dataSource;
  AuthRepository({required this.dataSource});
  @override
  Future<void> login(String username, String passwpord) async {
    final AuthInfo authInfo = await dataSource.login(username, passwpord);
    _persistAuthTokens(authInfo);
    debugPrint("access token is :" + authInfo.accessToken);
  }

  @override
  Future<void> signUp(String username, String passwpord) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, passwpord);
      _persistAuthTokens(authInfo);
      debugPrint("access token is :" + authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo = await dataSource.refreshToken(
      'def502001dd2f1b98f8cb2ed82fd8688a5b897ab3d76f4eb192942c40690d8a3d1afaaba0e51a3fb09364e010a2feadec6ccb87d69d277c28344638dfa0ea728c2ab75d02ed5c9c9f3a53ebcba362e8d20f745982c165c97f34eeb6522dc29403229d4dac1e6ca51ab9537210ab312d729d9e0515b19a807d72a6a1a386ae4c26935e7db1d147b6e19323eab6a7107c592222085b2c1364ab6b10a3d29ea21d093b1a6eeef8b322f234b5d8c4c30102dcbbe331be6b499c09390e3406b39ce7c7104fa46d1c18c65efc6163d2d3a0b1655028a7fc8f0c00981c23a19e0966a59b76edeb0a39add42b2974f1348df008c3554937c8fe47bf7e8332bed1c27a74214218664e2457377e9252112101911140cf8c2f6dc7625080c838ca09701b871d75ac97d2403c5c83a4a9f90c61470aca6165d1716157a5df0688bfd6d255e250cc48fda7641f5880d391641784cb5156154f51c41167f36d7d553cda4e2b7e238ba',
    );
    _persistAuthTokens(authInfo);
  }

  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('access_token', authInfo.accessToken);
    sharedPreferences.setString('refresh_token', authInfo.refreshToken);
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString("access_token") ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_token') ?? '';

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifire.value = AuthInfo(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }
  }
}
