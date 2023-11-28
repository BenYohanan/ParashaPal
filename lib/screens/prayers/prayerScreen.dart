import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pocket_siddur/app_properties.dart';
import 'package:pocket_siddur/models/prayer.dart';
import 'package:pocket_siddur/size_config.dart';

import '../../custom_background.dart';
import '../../enum.dart';
import '../home/components/customAppBar.dart';
import '../home/components/custom_bottom_bar.dart';

class PrayerPage extends StatefulWidget {
  final Prayers prayer;

  PrayerPage({required this.prayer});

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  final PageController _pageController = PageController(initialPage: 0);
  List<String> descriptionPages = [];
  int currentPage = 0;
  bool isPaginationVisible = false;
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    descriptionPages = splitPrayerIntoPages(widget.prayer.description, 10);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
      });
    });
    _startTimer();
  }

  List<String> splitPrayerIntoPages(String prayerContent, int numberOfPages) {
    List<String> paragraphs = prayerContent.split('\n\n');
    int paragraphsPerPage = (paragraphs.length / numberOfPages).ceil();
    List<String> prayerPages = [];
    for (int i = 0; i < paragraphs.length; i += paragraphsPerPage) {
      int end = (i + paragraphsPerPage < paragraphs.length)
          ? i + paragraphsPerPage
          : paragraphs.length;
      prayerPages.add(paragraphs.sublist(i, end).join('\n\n'));
    }
    return prayerPages;
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _restartTimer();
  }

  List<int> _getPageRange() {
    int totalPage = descriptionPages.length;
    int start = (currentPage ~/ 5) * 5;
    int end = start + 5;
    if (end > totalPage) {
      end = totalPage;
    }
    return List.generate(
      end - start,
      (index) => start + index + 1,
    );
  }

  Widget _buildBootstrapPaginationBar() {
    List<int> pageRange = _getPageRange();
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: AnimatedOpacity(
        opacity: isPaginationVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: getProportionateScreenHeight(50),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: currentPage > 0
                      ? () {
                          _goToPage(currentPage - 1);
                        }
                      : null,
                  icon: SvgPicture.asset(
                    "assets/icons/previous.svg",
                    color: Colors.white,
                  ),
                ),
                for (int page in pageRange)
                  ElevatedButton(
                    onPressed: () {
                      _goToPage(page - 1);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        page == currentPage + 1 ? darkGrey : Colors.white,
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        CircleBorder(),
                      ),
                    ),
                    child: Text(
                      '$page',
                      style: TextStyle(
                        color: page == currentPage + 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                IconButton(
                  onPressed: currentPage < descriptionPages.length - 1
                      ? () {
                          _goToPage(currentPage + 1);
                        }
                      : null,
                  icon: SvgPicture.asset(
                    "assets/icons/next.svg",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 5), () {
      setState(() {
        isPaginationVisible = false;
      });
    });
  }

  void _restartTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 5), () {
      setState(() {
        isPaginationVisible = false;
      });
    });
  }

  Widget _buildPage(String pageContent) {
    return Scrollbar(
      trackVisibility: true,
      thickness: 8,
      controller: _scrollController,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 30.0,
            bottom: 10,
            top: 10,
          ),
          child: Text(
            pageContent,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: getProportionateScreenHeight(15),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          AppBar().preferredSize.height,
        ),
        child: CustomAppBar(
          name: widget.prayer.time,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (isPaginationVisible == true) {
            setState(() {
              isPaginationVisible = false;
            });
          } else {
            setState(() {
              isPaginationVisible = true;
            });
          }
          _restartTimer();
        },
        child: Stack(
          children: [
            CustomPaint(
              painter: SiddurBackground(),
              child: Scrollbar(
                trackVisibility: true,
                thickness: 8,
                controller: _scrollController,
                child: PageView(
                  controller: _pageController,
                  children: descriptionPages.map(
                    (pageContent) {
                      return _buildPage(pageContent);
                    },
                  ).toList(),
                ),
              ),
            ),
            _buildBootstrapPaginationBar(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedMenu: NavBarMenuState.siddur,
      ),
    );
  }
}
