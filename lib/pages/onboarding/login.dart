import 'package:flutter/cupertino.dart';

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Login"),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: CupertinoColors.systemGrey4,
                    width: 1.0,
                  ),
                ),
                child: CupertinoTextField(
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  placeholder: "Username",
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
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
                child: CupertinoTextField(
                  controller: _passwordController,
                  obscureText: true,
                  placeholder: "Password",
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
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
              CupertinoButton(
                child: const Text("Login"),
                onPressed: () {
                  // if (_formKey.currentState.validate()) {
                  //   // Perform login
                  // }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
