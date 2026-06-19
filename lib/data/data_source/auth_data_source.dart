import 'package:app/common/constants.dart';
import 'package:app/common/http_client.dart';
import 'package:app/common/http_response_validatore.dart';
import 'package:app/data/auth_info.dart';
import 'package:dio/dio.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String passwpord);
  Future<AuthInfo> signUp(String username, String passwpord);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponseValidatore
    implements IAuthDataSource {
  final Dio dio;

  AuthRemoteDataSource({required this.dio});
  @override
  Future<AuthInfo> login(String username, String passwpord) async {
    final response = await httpClient.post(
      'auth/tokrn',
      data: {
        "grant_type": "password",
        "client_id": 2,
        "client_secret": Constants.clientSecret,
        "username": username,
        "password": passwpord,
      },
    );
    validateRespone(response);

    return AuthInfo(
      accessToken: response.data['access_token'],
      refreshToken: response.data['refresh_token'],
    );
  }

  @override
  Future<AuthInfo> refreshToken(String token) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<AuthInfo> signUp(String username, String passwpord) async {
    final response = await httpClient.post(
      'user/register',
      data: {"email": username, "password": passwpord},
    );
    validateRespone(response);
    return login(username, passwpord);
  }
}
