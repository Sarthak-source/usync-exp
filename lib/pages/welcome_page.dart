import 'package:chatsampleapp/ui/typography/text.dart';
import 'package:flutter/cupertino.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: CupertinoPageScaffold(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              UsyncText('Welcome...',
                  type: UsyncTextType.subHeadlineBold,
                  padding: EdgeInsets.only(bottom: 10)),
              // CallTimer()
            ],
          ),
        ),
      )),
    );
  }
}
