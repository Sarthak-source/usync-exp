import 'dart:convert';
import 'dart:io';
import 'package:clean_api/clean_api.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'api.dart';

class APIService {
  String noInternetMsg = 'You are not connected to Internet';
  String errorMsg = 'Please try again later.';

  /// Variables
  bool accessAllowed = false;

  String access = 'ACCESS';
  String loggedIn = 'LOGGED_IN';

  bool isSuccessful(int code) {
    return code >= 200 && code <= 206;
  }

  Future<Response> getRequest(String? endPoint,
      {bool bearerToken = false, bool noBaseUrl = false}) async {
    if (await isNetworkAvailable()) {
      Map<String, String>? headers;
      Response response;
      var accessToken = getStringAsync(access);

      if (bearerToken) {
        headers = {
          HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
          "Authorization": "Bearer $accessToken"
        };
      }

      if (!noBaseUrl) {
        Logger.i('URL: ${API.base}$endPoint');
      } else {
        Logger.i('URL: $endPoint');
      }
      //debugPrint('Header: $headers');

      if (bearerToken) {
        response =
            await get(Uri.parse('${API.base}$endPoint'), headers: headers);
      } else if (noBaseUrl) {
        response = await get(Uri.parse('$endPoint'));
      } else {
        response = await get(Uri.parse('${API.base}$endPoint'));
      }

      //debugPrint('Response: ${response.statusCode} ${response.body}');
      return response;
    } else {
      throw noInternetMsg;
    }
  }

  postRequest(String endPoint, Map? requestBody,
      {bool bearerToken = false, bool noBaseUrl = false}) async {
    if (await isNetworkAvailable()) {
      Response? response;
      if (!noBaseUrl) {
        Logger.e('URL: ${API.base}$endPoint');
      } else {
        Logger.i('URL: $endPoint');
      }
      Logger.i('body: $requestBody');

      var accessToken = getStringAsync(access);

      var headers = {
        HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
      };

      if (bearerToken) {
        var header = {"Authorization": "Bearer $accessToken"};
        headers.addAll(header);
      }

      Logger.i("Headers: $headers");
      try {
        if (!noBaseUrl) {
          response = await post(Uri.parse('${API.base}$endPoint'),
              body: requestBody, headers: headers);
        } else {
          response = await post(Uri.parse(endPoint),
              body: requestBody, headers: headers);
        }
      } catch (e) {
        Logger.e(e.toString());
      }
      //debugPrint('Response: ${response.statusCode} ${response.body}');
      return response;
    } else {
      throw noInternetMsg;
    }
  }

  putRequest(String endPoint, Map request, {bool bearerToken = true}) async {
    if (await isNetworkAvailable()) {
      late Response response;
      Logger.i('URL: ${API.base}$endPoint');
      Logger.i('Request: $request');

      var accessToken = getStringAsync(access);

      var headers = {
        HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
      };

      if (bearerToken) {
        var header = {"Authorization": "Bearer $accessToken"};
        headers.addAll(header);
      }

      Logger.i("Headers: $headers");
      try {
        response = await put(Uri.parse('${API.base}$endPoint'),
            body: request, headers: headers);
      } catch (e) {
        Logger.e(e);
      }
      Logger.i('Response: ${response.statusCode} ${response.body}');
      return response;
    } else {
      throw noInternetMsg;
    }
  }

  patchRequest(String endPoint, Map request,
      {bool requireToken = false,
      bool bearerToken = false,
      bool isDigitToken = false}) {}

  deleteRequest(String endPoint, {bool bearerToken = true}) async {
    if (await isNetworkAvailable()) {
      var accessToken = getStringAsync(access);
      Logger.i('URL: ${API.base}$endPoint');

      var headers = {
        HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
      };

      if (bearerToken) {
        var header = {"Authorization": "Bearer $accessToken"};
        headers.addAll(header);
      }

      Logger.i(headers.toString());
      Response response =
          await delete(Uri.parse('${API.base}$endPoint'), headers: headers);
      Logger.i('Response: ${response.statusCode} ${response.body}');
      return response;
    } else {
      throw noInternetMsg;
    }
  }

  Future handleResponse(Response response, {bool showToast = true}) async {
    if (!await isNetworkAvailable()) {
      throw noInternetMsg;
    }
    if (isSuccessful(response.statusCode)) {
      if (response.body.isNotEmpty) {
        Logger.i(response.statusCode.toString());
        Logger.i(response.body);
        return jsonDecode(response.body);
      } else {
        return response.body;
      }
    } else {
      if (response.body.isJson()) {
        Logger.i("handleResponse (json): ${jsonDecode(response.body)}");
        if (jsonDecode(response.body)['errors'] != null) {
          toast(
            jsonDecode(response.body)['errors']
                [jsonDecode(response.body)['errors'].keys.first][0],
          );
        } else if (showToast) {
          toast(
            jsonDecode(response.body)['message'] ??
                jsonDecode(response.body)['error'],
          );
        }

        if (response.statusCode == 401) {
          await getSharedPref().then((value) => value.clear());
        }

        return response.statusCode;
      } else {
        try {
          Logger.i("handleResponse: ${jsonDecode(response.body)}");
        } catch (e) {
          Logger.e(response.body);
          return 500;
        }
        return response.statusCode;
      }
    }
  }
}
