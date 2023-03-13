import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/network/api.dart';
import 'package:usync/data/network/network_utils.dart';
import 'package:usync/data/view_models/log_in_view_model/log_in_view_model.dart';
import 'package:usync/data/view_models/user_view_model/user_view_model.dart';
import 'package:usync/main.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/usync_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> myAsyncMethod(BuildContext context) async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }

    double width = MediaQuery.of(context).size.width;

    return AppPanel(
      radius: AppPanelRadius.xs,
      content: [
        AppPanelHeader(
          back: false,
          search: false,
          toolbarHeight: 65,
          onBackClick: () {},
          onSearchCancel: () {},
          onSearchInput: (p0) {},
          actionButtons: [
            IconButton(
              icon: const FaIcon(
                Icons.add_circle_outline,
              ),
              onPressed: () {},
            ),
          ],
          child: Container(),
        ),
        Expanded(
          child: ViewModelBuilder<LoginViewModel>.reactive(
            viewModelBuilder: () => LoginViewModel(),
            builder: (context, loginmodel, child) => Scaffold(
              body: ViewModelBuilder<UserViewModel>.reactive(
                  viewModelBuilder: () => UserViewModel(),
                  builder: (context, usermodel, child) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('usync'),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('What matters is the experience.'),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: CupertinoColors.systemGrey4,
                                  width: 1.0,
                                ),
                              ),
                              child: UsyncTextField(
                                textController: _usernameController,
                                keyboardType: TextInputType.emailAddress,
                                placeholderString: "Username",

                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return "Please enter a username";
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: CupertinoColors.systemGrey4,
                                  width: 1.0,
                                ),
                              ),
                              child: UsyncTextField(
                                textController: _passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                placeholderString: "Password",

                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return "Please enter a password";
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            SizedBox(
                              width: width,
                              child: CupertinoButton(
                                color: LightThemeColors.primary,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var success = await loginmodel.login(
                                      _usernameController.text,
                                      _passwordController.text,
                                    );
                                    if (success) {
                                      await usermodel.getUser();
                                      if (!mounted) return;
                                      myAsyncMethod(context);
                                    } else {
                                      // Handle login failure
                                      debugPrint('no login');
                                    }
                                  }
                                },
                                child: const Text("Sign in"),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var success = await loginmodel.login(
                                    _usernameController.text,
                                    _passwordController.text,
                                  );
                                  if (success) {
                                    if (!mounted) return;
                                    myAsyncMethod(context);
                                  } else {
                                    // Handle login failure
                                    debugPrint('no login');
                                  }
                                }
                              },
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: LightThemeColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            const Text('Don\'t have an account?'),
                            const SizedBox(
                              height: 16.0,
                            ),
                            SizedBox(
                              width: width,
                              child: CupertinoButton(
                                color: LightThemeColors.primary,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var success = await loginmodel.login(
                                      _usernameController.text,
                                      _passwordController.text,
                                    );
                                    if (success) {
                                      if (!mounted) return;
                                      myAsyncMethod(context);
                                    } else {
                                      // Handle login failure
                                      debugPrint('no login');
                                    }
                                  }
                                },
                                child: const Text("Sign up"),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var success = await loginmodel.login(
                                          _usernameController.text,
                                          _passwordController.text,
                                        );
                                        if (success) {
                                          if (!mounted) return;
                                          myAsyncMethod(context);
                                        } else {
                                          // Handle login failure
                                          debugPrint('no login');
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "About",
                                      style: TextStyle(
                                        color: LightThemeColors.primary,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        var success = await loginmodel.login(
                                          _usernameController.text,
                                          _passwordController.text,
                                        );
                                        if (success) {
                                          if (!mounted) return;
                                          myAsyncMethod(context);
                                        } else {
                                          // Handle login failure
                                          debugPrint('no login');
                                        }
                                      }
                                    },
                                    child: const Text(
                                      "Legal",
                                      style: TextStyle(
                                        color: LightThemeColors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
