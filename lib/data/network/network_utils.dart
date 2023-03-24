import 'dart:convert';
import 'dart:io';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:usync/config/config.dart';
import 'package:usync/utils/redux_token.dart';
import 'api.dart';

class APIService {
  String noInternetMsg = 'You are not connected to Internet';
  String errorMsg = 'Please try again later.';

  /// Variables
  bool accessAllowed = false;

  // String tokenValue =
  //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiYTA1NmEzZDE1N2FjZTEyYzQ3MWUyYmE3NDg2MzNiZWY5NjY5MjA4YWVkNWI5NDhhYjYyZTA3OWM3MzhiODFjZjM3OTYxZDkyZDFmNWUyNGMiLCJpYXQiOjE2NzU4NTY0NjguMTIyNzYsIm5iZiI6MTY3NTg1NjQ2OC4xMjI3NjcsImV4cCI6MTcwNzM5MjQ2Ny41NjQ4MjksInN1YiI6IjE1Iiwic2NvcGVzIjpbXX0.Ku8aUfjHSXjIfJwu6M9-jUxUNpdjcgBsQvrBN4gqeGiJ-4K2ERfh4jxVcryImgJYbO2C4Da-f7ffNt4wELPaXzI5qk9oCVY9aK5LlgAFJVrGkV8MlSpfWEVOLRAkrBXJCjREXsHNFVi2IDClCRuLsAPLPDdlBdOQGzHdzBD9kbYNkUxW8HllWO8fv7DNz3p_O-r3frzoBOa-ZUvn7iAwT57eNM6t-MYWKKWYB-fDxiDnk_yFHV9sYKqFuB_R4NtLAUvVc8kVHz2YnN3Ex6flogg4ogviWba5YVkal-y1BChnR6z7qUT5RAlAVsXHjA1x2QNdgp1V77IfaoGv-hjJ6VJhBeCeVx1TgyBN0MVhPAmmxkZ89aZjdXs46RDZ-AM-1WhEXH1XRqIGdZL8ifBMvvD18NN3OfOjnEWOddMrH7nNR5x2JFQgTfSwy5Ca7Z9XW6BKgL1r6f46fz-oJ04AaD06OtWbUmq9DWn10AghDBT73w0SHRUq6ODz-KEgefSM8cpAKqvbJYKyqSs8OPgrvKJd5nybhkuvDJKbwOifdZRJeh8udWPfMvvRlEamklbFzPPoHa8x-g73MdUilA9UOIPmTp0KeIAOg8_kgBlyCFUh6lXjj0Egk4nPopctMooF29v8ADOTOwqj2pL94VWnq5qGOzPrPs3pNS7Vc7JoqTw';

  String loggedIn = 'LOGGED_IN';

  String access = MyConfig.access;

  bool isSuccessful(int code) {
    return code >= 200 && code <= 206;
  }

  setToken(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  Future<Response> getRequest(String endPoint,
      {bool bearerToken = false,
      bool noBaseUrl = false,
      Map<String, dynamic>? queryParams}) async {
    if (await isNetworkAvailable()) {
      Map<String, String>? headers;
      Response response;
      var accessToken = ReduxToken.instance.store.state.accessToken;

      debugPrint('getRequest ReduxToken-----$accessToken');

      if (bearerToken) {
        headers = {
          HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
          "Authorization": "Bearer $accessToken"
        };
        debugPrint('header-----$headers');
      }

      if (!noBaseUrl) {
        Logger.i('URL: ${API.base}$endPoint');
      } else {
        Logger.i('URL: $endPoint');
      }
      //debugPrint('Header: $headers');
      String apiBaseURL =
          API.base.startsWith('https://') ? Uri.parse(API.base).host : API.base;

      String apiPrefix = Uri.parse(API.base).path;

      if (bearerToken) {
        response = await get(
            Uri.https(apiBaseURL, '$apiPrefix$endPoint', queryParams),
            headers: headers);
      } else if (noBaseUrl) {
        response = await get(Uri.https(apiBaseURL, endPoint, queryParams),
            headers: headers);
      } else {
        response = await get(
            Uri.https(apiBaseURL, '$apiPrefix$endPoint', queryParams),
            headers: headers);
      }

      //debugPrint('Response: ${response.statusCode} ${response.body}');
      Logger.i(response.body);
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

// Get access token from store
      var accessToken = ReduxToken.instance.store.state.accessToken;

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

      var accessToken = ReduxToken.instance.store.state.accessToken;

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
      var accessToken = ReduxToken.instance.store.state.accessToken;
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
