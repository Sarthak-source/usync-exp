import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_section.dart';

List<Widget> subpaneldetails(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return [
    const AppPanelHeader(
      actionButtons: [],
      child: Text('details'),
    ),
    const SizedBox(
      height: 30,
    ),
    AppPanelSection(
      height: 5.5,
      body: [
        SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: const NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
                  ),
                  radius: 25,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.all(5.0),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text('Ann Williams'),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const FaIcon(Icons.message)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.call),
                ),
              ],
            ),
          ),
        ),
      ],
      direction: Axis.vertical,
      gutter: 0,
    ),
    const SizedBox(
      height: 30,
    ),
    AppPanelSection(
      height: 5,
      body: [
        SizedBox(
          width: width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text('Hide Alerts'),
              const Spacer(),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  //activeColor: activeColor,
                  value: true,
                  onChanged: (v) {},
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        SizedBox(
          width: width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text('Send Read Recipts'),
              const Spacer(),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  //activeColor: activeColor,
                  value: true,
                  onChanged: (v) {},
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        SizedBox(
          width: width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 20,
              ),
              Text('Send Current Location'),
              Spacer(),
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Location sharing is disabled. Enable it by\ngoing into your',
                ),
                TextSpan(
                  text: ' settings.',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ),
      ],
      direction: Axis.vertical,
      gutter: 0,
    ),
  ];
}
