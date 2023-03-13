import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class TokenState {
  final String? accessToken;

  TokenState({this.accessToken});

  factory TokenState.initial() {
    return TokenState(accessToken: null);
  }
}

class UpdateAccessTokenAction {
  final String accessToken;

  UpdateAccessTokenAction(this.accessToken);
}

TokenState appReducer(TokenState state, dynamic action) {
  if (action is UpdateAccessTokenAction) {
    return TokenState(accessToken: action.accessToken);
  }
  return state;
}

class ReduxToken {
  static final ReduxToken instance = ReduxToken._init();

  ReduxToken._init();

  late Store<TokenState> store;

  Future<void> initStore() async {
    store = Store<TokenState>(appReducer,
        initialState: TokenState.initial(), middleware: [thunkMiddleware]);
  }
}

ThunkAction<TokenState> setAccessToken(String accessToken) {
  return (Store<TokenState> store) async {
    await store.dispatch(UpdateAccessTokenAction(accessToken));
  };
}
