import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_section.dart';
import 'package:usync/ui_components/globalcomponents/photo_grid.dart';
import 'package:usync/ui_components/usync_text_field.dart';
import 'package:usync/utils/place_holder.dart';

List<Widget> subpaneldetails(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  return [
    AppPanelHeader(
      toolbarHeight: 70,
      actionButtons: const [],
      onBackClick: () {
        Navigator.pop(context);
      },
      child: const Text('details'),
    ),
    const SizedBox(
      height: 30,
    ),
    AppPanelSection(
      height: 150,
      body: [
        SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          padding: const EdgeInsets.all(5.0),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('Ann Williams'),
                      const Spacer(),
                      IconButton(
                          onPressed: () {}, icon: const FaIcon(Icons.message)),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.call),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: UsyncTextField(
                    placeholderString: 'search',
                    prifix: const Padding(
                      padding: EdgeInsets.only(
                        left: 5,
                      ),
                      child: Icon(Icons.add_circle_outline),
                    ),
                  ),
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
      height: 230,
      body: [
        const SizedBox(
          height: 10,
        ),
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
        const Divider(
          color: Colors.white,
        ),
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
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
    const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text('PHOTOS'),
      ),
    ),
    AppPanelSection(
      height: ((imageList.length / 2) * 250) + 230,
      body: [
        SizedBox(
          width: width,
          child: const PhotoGrid(),
        ),
      ],
      direction: Axis.vertical,
      gutter: 0,
    ),
  ];
}
