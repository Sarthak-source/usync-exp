import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:usync/pages/conversation/chat_list/conversation_page.dart';
import 'package:usync/ui_components/config/theme/styles/theme_colors.dart';
import 'package:usync/ui_components/globalcomponents/app_panel.dart';
import 'package:usync/ui_components/globalcomponents/app_panel_header.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;

    const double _playerMinHeight = 60.0;

    int _selectedIndex = 0;

    final pages = [
      const ConversationsPage(title: 'Conversation'),
      const ConversationsPage(title: 'Conversation'),
      const ConversationsPage(title: 'Conversation'),
      const ConversationsPage(title: 'Conversation'),
    ];

    return AppPanel(
      content: [
        AppPanelHeader(
          search: true,
          toolbarHeight: 65,
          onBackClick: () {
            Navigator.pop(context);
          },
          onSearchCancel: () {},
          onSearchInput: (p0) {},
          actionButtons: [
            IconButton(
              icon: const FaIcon(
                Icons.add_circle_outline,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          child: const Text(
            'Now playing',
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              SizedBox.expand(child: PageView()),
              Miniplayer(
                controller: null,
                minHeight: _playerMinHeight,
                maxHeight: MediaQuery.of(context).size.height / 1.2,
                builder: (height, percentage) {
                  return Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.network(
                              'https://assets.rebelmouse.io/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpbWFnZSI6Imh0dHBzOi8vYXNzZXRzLnJibC5tcy8yNDk4NzQ0OS9vcmlnaW4uanBnIiwiZXhwaXJlc19hdCI6MTY3MTk2MjkzM30.Uwvlog9sqX7t1zRWCMEWiletZn9O7VpsJ-J7j3AvoX0/img.jpg?width=980',
                              height: _playerMinHeight - 4.0,
                              width: 120.0,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'My name is',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        'M M LP',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const LinearProgressIndicator(
                          value: 0.4,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            LightThemeColors.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ? const Icon(
                        Icons.home_filled,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: pageIndex == 1
                    ? const Icon(
                        Icons.work_rounded,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.work_outline_outlined,
                        color: Colors.white,
                      ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {});
                },
                icon: pageIndex == 2
                    ? const Icon(
                        Icons.widgets_rounded,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.widgets_outlined,
                        color: Colors.white,
                      ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: pageIndex == 3
                    ? const Icon(
                        Icons.person,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
