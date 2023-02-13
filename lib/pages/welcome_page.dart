import 'package:flutter/cupertino.dart';
import 'package:flutter_module/ui/typography/text.dart';

class WelcomePage extends StatelessWidget {
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
