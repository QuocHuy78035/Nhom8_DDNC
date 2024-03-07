import 'dart:convert';
import 'package:ddnangcao_project/utils/global_variable.dart';
import 'package:http/http.dart' as https;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ApiService {
  get({required String url});
  post({required String url, required Map<String, dynamic> params});
  delete({required String url});
  put();
  patch({required String url});
}

class ApiServiceImpl extends ApiService {
  @override
  post(
      {required String url,
      required Map<String, dynamic> params,
      bool needTokenAndUserId = true,
      bool changeUrl = false}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? token;
    String? userId;

    if (needTokenAndUserId) {
      token = await getNewToken();
      userId = sharedPreferences.getString("userId");
    }

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (needTokenAndUserId && token != null) {
      headers['authorization'] = token;
      headers['x-client-id'] = userId ?? "";
    }

    final String baseUrl;
    if (changeUrl == false) {
      baseUrl = '${GlobalVariable.apiUrl}/$url';
    } else {
      baseUrl = url;
    }

    return https.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(
        params,
      ),
    );
  }

  @override
  get({required String url}) async {
    final String token = await getNewToken();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userId = sharedPreferences.getString("userId");
    return https.get(
      Uri.parse("${GlobalVariable.apiUrl}/$url"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token,
        'x-client-id': userId ?? "",
      },
    );
  }

  @override
  put() {}

  @override
  delete({required String url}) async {
    final String token = await getNewToken();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userId = sharedPreferences.getString("userId");
    return https.delete(
      Uri.parse("${GlobalVariable.apiUrl}/$url"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token,
        'x-client-id': userId ?? "",
      },
    );
  }


  @override
  patch({required String url}) async{
    final String token = await getNewToken();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userId = sharedPreferences.getString("userId");
    return https.patch(
      Uri.parse("${GlobalVariable.apiUrl}/$url"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': token,
        'x-client-id': userId ?? "",
      },
    );
  }

  Future<String> getNewToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("accessToken") ?? "";
    String refreshToken = sharedPreferences.getString("refreshToken") ?? "";

    bool isExpired = isTokenExpired(token);
    if (isExpired) {
      Future<String> getNewToken(String refreshToken) async {
        final String tokenNew;
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        final String? refreshToken =
            sharedPreferences.getString("refreshToken");
        final String? userId = sharedPreferences.getString("userId");
        final response = await https.post(
          Uri.parse("${GlobalVariable.apiUrl}/refreshToken"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "x-client-id": userId ?? ""
          },
          body: jsonEncode(
            {"refreshToken": refreshToken},
          ),
        );
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 200) {
          print(data);
          tokenNew = data['metadata']['tokens']['accessToken'];
          sharedPreferences.setString("accessToken", tokenNew);
        } else {
          throw Exception('Fail to refresh token');
        }
        return tokenNew;
      }

      String newToken = await getNewToken(refreshToken);
      sharedPreferences.setString("accessToken", newToken);
      return newToken;
    } else {
      return token;
    }
  }

  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }
}
