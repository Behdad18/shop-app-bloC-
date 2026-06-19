import 'package:app/common/http_client.dart';
import 'package:app/data/auth_info.dart';
import 'package:app/data/data_source/auth_data_source.dart';
import 'package:flutter/rendering.dart';

final authRepository = AuthRepository(
  dataSource: AuthRemoteDataSource(dio: httpClient),
);

abstract class IAuthRepository {
  Future<void> login(String username, String passwpord);
  Future<void> signUp(String username, String passwpord);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository({required this.dataSource});
  @override
  Future<void> login(String username, String passwpord) async {
    final AuthInfo authInfo = await dataSource.login(username, passwpord);
    debugPrint("access token is :" + authInfo.accessToken);
  }

  @override
  Future<void> signUp(String username, String passwpord) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, passwpord);
      debugPrint("access token is :" + authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
