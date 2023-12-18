import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pocket_siddur/size_config.dart';

import '../../../custom_background.dart';
import '../../../enum.dart';
import '../../../models/parasha.dart';
import '../../home/components/customAppBar.dart';
import '../../home/components/custom_bottom_bar.dart';

class ParashaSummaryPage extends StatefulWidget {
  final Parasha parasha;
  bool? isFromHomepage;
  final String? route;
  ParashaSummaryPage({
    required this.parasha,
    this.isFromHomepage,
    this.route,
  });

  @override
  State<ParashaSummaryPage> createState() => _ParashaSummaryPageState();
}

class _ParashaSummaryPageState extends State<ParashaSummaryPage> {
  final PageController _pageController = PageController(initialPage: 0);
  List<String> descriptionPages = [];
  int currentPage = 0;
  bool isPaginationVisible = false;
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    descriptionPages = splitPrayerIntoPages(widget.parasha.summary!, 1);
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
          name: widget.parasha.name,
          isFromHomePage: widget.isFromHomepage,
          routeName: widget.route,
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
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedMenu: NavBarMenuState.parasha,
      ),
    );
  }
}
