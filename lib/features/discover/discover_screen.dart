import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

final tabs = [
  'Top',
  'Users',
  'Videos',
  'Sounds',
  'lIVE',
  'Shopping',
  'Brands',
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late TabController _tabController;
  bool _isInputtingSearchValue = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
    _tabController.addListener(_dismissSearchKeyboardAsTabIndexChanged);
  }

  void _onSearchTextChanged(String value) {
    setState(() {
      _isInputtingSearchValue = value.isNotEmpty;
    });
  }

  void _onSearchTextSubmitted(String value) {
    print('Submitted $value');
  }

  void _onBackButtonTap() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(),
      ),
    );
  }

  void _onXmarkTap() {
    setState(() {
      _textEditingController.text = '';
      _isInputtingSearchValue = false;
    });
  }

  void _dismissSearchKeyboardAsTabIndexChanged() {
    if (_tabController.indexIsChanging) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose(); // Don't forget to dispose the controller
    _tabController.removeListener(_dismissSearchKeyboardAsTabIndexChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // title: CupertinoSearchTextField(
          //   controller: _textEditingController,
          //   onChanged: _onSearchTextChanged,
          //   onSubmitted: _onSearchTextSubmitted,
          // ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _onBackButtonTap,
                child: const FaIcon(FontAwesomeIcons.chevronLeft,
                  color: Colors.black87,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size18),
                  height: Sizes.size44,
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: _onSearchTextChanged,
                    onSubmitted: _onSearchTextSubmitted,
                    textInputAction: TextInputAction.search,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Sizes.size12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size12,
                        vertical: Sizes.size10,
                      ),
                      prefixIcon: Container(
                        width: Sizes.size20,
                        alignment: Alignment.center,
                        child: FaIcon(FontAwesomeIcons.magnifyingGlass,
                          color: Colors.grey.shade600,
                          size: Sizes.size16,
                        ),
                      ),
                      suffixIcon: Container(
                        width: Sizes.size20,
                        alignment: Alignment.center,
                        child: AnimatedOpacity(
                          opacity: _isInputtingSearchValue ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: GestureDetector(
                            onTap: _onXmarkTap,
                            child: FaIcon(FontAwesomeIcons.solidCircleXmark,
                              color: Colors.grey.shade600,
                              size: Sizes.size16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const FaIcon(FontAwesomeIcons.sliders,
                color: Colors.black87,
              ),
            ],
          ),
          elevation: 1, // Works as an underline for the appBar
          bottom: TabBar( // bottom has the type of PreferredSizeWidget, wishes to be at a certain size but does not constrain the size of its children, which usually comes as a TabBar
            controller: _tabController,
            // controller: _tabController,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            splashFactory: NoSplash.splashFactory, // Erases the splash effect when a tab is clicked
            labelColor: Colors.black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            tabs: [for (var tab in tabs)
              Tab(
                text: tab,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: const EdgeInsets.all(Sizes.size6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 24,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/IMG_0073.JPG', // The image in assets folders is used as a placeholder
                        image: 'https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80',
                      ),
                    ),
                  ),
                  Gaps.v10,
                  const Text('This is a very long caption for my TikTok that I am uploading now what what',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v8,
                  DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/0722-0-21-1659275415.jpg?crop=1.00xw:0.753xh;0,0.0336xh&resize=980:*',
                          ),
                          radius: 12,
                        ),
                        Gaps.h4,
                        const Expanded(
                          child: Text('My avatar has a very long txt to describe itself wow so lengthy',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(FontAwesomeIcons.heart,
                          size: Sizes.size16,
                          color: Colors.grey.shade600,
                        ),
                        Gaps.h2,
                        const Text('2.5M'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            for (var tab in tabs.skip(1)) // Skipping the 0th one because of the GridView above
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size28,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
