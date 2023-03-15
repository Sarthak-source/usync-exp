import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/network/api.dart';
import 'package:usync/data/network/network_utils.dart';

class SendChatViewModel extends BaseViewModel {
  final String? convesationId;

  SendChatViewModel({
    required this.convesationId,
  });

  final APIService _apiService = APIService();

  String _message = '';

  String get email => _message;

  String sendChatUrl = API.messages;

  void updateMessage(String value) {
    _message = value;
    notifyListeners();
  }

  Future<bool> sendChat(String message, String convesationId) async {
    // Implement your SendChat logic here
    // Use _email and _password to make a request to your backend API
    // Handle success and failure cases as needed

    var result = await _apiService.postRequest(
      sendChatUrl,
      {'message': message, 'conversation': convesationId},
    );

    if (result.statusCode == 200) {
      final decoded = await _apiService.handleResponse(result);

      debugPrint('SendChat--TOKEN--$decoded');
      return true;
    } else {
      // handle the error
      return false;
    }
  }
}
