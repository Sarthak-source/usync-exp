import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/models/hive_file/file.dart';
import 'package:usync/data/models/hive_user/user.dart';
import 'package:usync/data/network/api.dart';
import 'package:usync/data/network/network_utils.dart';

class SearchViewModel extends BaseViewModel {
  final APIService apiService = APIService();

  String _search = '';
  String get search => _search;
  final List<User> _searchList = [];
  List<User> get searchList => _searchList;
  String searchUrl = API.search;
  String _text = "";
  String get text => _text;

  void updateSearch(String value) {
    _search = value;
    notifyListeners();
  }

  getSearch(String search) async {
    debugPrint("Entered get Data()");
    _text = "Fetching data";

    _text = "Fetching from hive";
    debugPrint("Getting data from Api");
    setBusy(true);
    var result = await apiService.getRequest(
      searchUrl,
      bearerToken: true,
      queryParams: {
        'search': search,
        'include': 'avatar',
      },
    );
    var decoded = await apiService.handleResponse(result);
    debugPrint('decoded---$decoded');
    notifyListeners();
    (decoded['data'] as List).map((e) {
      debugPrint(e.toString());

      File avatar = mapJsonToFile(e);

      User user = mapJsonToUser(e, avatar, File());

      _searchList.add(user);
    }).toList();
    _text = "Caching data";

    setBusy(false);
  }

  List<String> getImage(User user) {
    List<String> imageLinks = [];
    try {
      var userAvatar = user.avatar;
      if (userAvatar != null) {
        var userAvatarLinks = userAvatar.links;
        if (userAvatarLinks != null) {
          String userAvatarUrl = userAvatarLinks['xs']['url'];
          imageLinks.add(userAvatarUrl);
        }
      }
    } catch (e) {
      print('Error occurred while getting image: $e');
      // Return a default value or throw an error message
      // depending on your use case.
    }
    return imageLinks;
  }
}
