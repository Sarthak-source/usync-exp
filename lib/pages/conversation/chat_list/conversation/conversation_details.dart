import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:usync/data/models/hive_user/user.dart';
import 'package:usync/data/view_models/search_view_model/search_view_model.dart';
import 'package:usync/ui_components/avatar.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_section.dart';
import 'package:usync/ui_components/globalcomponents/photo_grid.dart';
import 'package:usync/utils/place_holder.dart';
import 'package:usync/utils/theme_color.dart';

List<Widget> subpaneldetails(
  BuildContext context,
  String name,
  List<String> imageUrl,
) {
  double width = MediaQuery.of(context).size.width;
  final searchController = TextEditingController();

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
      height: 170,
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
                      Avatar(
                        imageUrl: imageUrl,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 160,
                        child: Text(name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis)),
                      ),
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
                ViewModelBuilder<SearchViewModel>.reactive(
                  viewModelBuilder: () => SearchViewModel(),
                  onViewModelReady: (searchModel) =>
                      searchModel.getSearch(searchController.text),
                  builder: (context, searchModel, child) {
                    List<User> users = searchModel.searchList;
                    return SizedBox(
                      height: 45,
                      child: Autocomplete<User>(
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                filled: true,
                                labelText: 'uSync search',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    CupertinoIcons.chevron_down,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              controller: textEditingController,
                              focusNode: focusNode,
                              onChanged: (value) {},
                              onSubmitted: (value) {
                                // Your onSubmitted logic here
                              },
                            ),
                          );
                        },
                        optionsBuilder:
                            (TextEditingValue textEditingValue) async {
                          // You can replace this with your own logic for retrieving suggestions
                          final suggestions = users
                              .where((User option) => option.name!['full']
                                  .toString().toLowerCase()
                                  .contains(
                                      textEditingValue.text.toLowerCase()))
                              .toList();

                          return suggestions;
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<User> onSelected,
                            Iterable<User> options) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Material(
                              color: ThemeColor().bgThemecolor(context),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              elevation: 10,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(10.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final dynamic option =
                                      options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      leading: Avatar(
                                        imageUrl: searchModel.getImage(option),
                                        size: 20,
                                      ),
                                      title: Text(
                                        '${option.name['full']}',
                                      ),
                                      subtitle: const Text('User'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        optionsMaxHeight: 25,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        //listView(personsList)
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
