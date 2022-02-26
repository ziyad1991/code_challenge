import 'dart:async';
import 'package:code_challenge/reorderable_grid_view/reorderable_grid_item.dart';
import 'package:code_challenge/reorderable_grid_view/reorderable_grid_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(IGrooveCodeChallenge());
}

class IGrooveCodeChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CodeChallenge(title: 'iGroove CodeChallenge'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CodeChallenge extends StatefulWidget {
  CodeChallenge({Key? key, this.title, this.scrollUpdateTrigger})
      : super(key: key);

  final Function(ScrollController?)? scrollUpdateTrigger;
  final String? title;

  @override
  _CodeChallengeState createState() => _CodeChallengeState();
}

class _CodeChallengeState extends State<CodeChallenge> {
  ScrollController? _scrollController;
  List<int?>? savedOrder;
  late Timer _everySecond;
  bool _changeHeight = false;
  bool _showExample = true;
  bool _timerStarted = false;

  List<Widget> cashboardItems = [
    ReorderableGridItem(
      widthFlex: 1,
      key: GlobalKey(),
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.red),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed "
            "diam nonumy eirmod tempor invidunt ut labore et dolore magna "
            "aliquyam erat, sed diam voluptua. At vero eos et accusam et "
            "justo duo dolores et ea rebum. Stet clita kasd gubergren, no "
            "sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem "
            "ipsum dolor sit amet, consetetur sadipscing elitr, sed diam "
            "nonumy eirmod tempor invidunt ut labore et dolore magna "
            "aliquyam erat, sed diam voluptua. At vero eos et accusam et "
            "justo duo dolores et ea rebum. Stet clita kasd gubergren, no "
            "sea takimata sanctus est Lorem ipsum dolor sit amet.",
            overflow: TextOverflow.visible,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      allowDrag: true,
    ),
    ReorderableGridItem(
      widthFlex: 1,
      key: GlobalKey(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: 75,
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.blue),
      ),
      allowDrag: true,
    ),
    ReorderableGridItem(
      widthFlex: 1,
      key: GlobalKey(),
      child: Container(
        height: 75,
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.yellow),
      ),
      allowDrag: true,
    ),
    ReorderableGridItem(
      widthFlex: 1,
      key: GlobalKey(),
      child: TheAnimatedContainer(),
      allowDrag: true,
    ),
    ReorderableGridItem(
      widthFlex: 1,
      key: GlobalKey(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: const Center(
          child: Text(
            "Info: With a longPress on the boxes you can reorder them to "
            "different positions.",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, height: 18 / 14),
          ),
        ),
      ),
      allowDrag: false,
    ),
  ];

  @override
  void initState() {
    _initScrollController();
    if (_showExample) {
      _startTimer();
    }
    super.initState();
  }

  void switchView() {
    if (_timerStarted) {
      _stopTimer();
    } else {
      _startTimer();
    }
    setState(() {
      _showExample = !_showExample;
    });
  }

  void _startTimer() {
    if (_timerStarted == false) {
      _timerStarted = true;
      _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          _changeHeight = !_changeHeight;
        });
      });
    }
  }

  void _stopTimer() {
    if (_timerStarted) {
      _timerStarted = false;
      _everySecond.cancel();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initScrollController() {
    _scrollController = ScrollController()
      ..addListener(() {
        var base = widget.scrollUpdateTrigger;
        if (base != null) {
          // Safe
          base(_scrollController);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5855DC),
        title: Text(
          widget.title!,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: _showExample
            ? Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Center(
                      child: Text(
                        "Hi,"
                        "\n\nthe tasks listed below should be done on the second view."
                        "\n\n1. Integrate the AnimatedContainer below to the next view "
                        "so it can be reordered there too and it should not stop changing "
                        "his size and should not overlap the other boxes. "
                        "The space between the boxes should stay at all time the same. "
                        "\n\n2. The overflowing text should be completely visible inside the "
                        "red box and the height of the box should be adjusted to his content."
                        "\n\n3. Thrown exceptions during the development must be solved."
                        "\n\n4. Refactoring the code can be done if wanted but the "
                        "ReorderableGridView cannot be replaced."
                        "\n\nInfo: You get to the second view via the button on the bottom.",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 18 / 14),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    height: _changeHeight ? 75 : 150,
                    margin: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Color(0xff5855DC)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Good luck",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 36),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.white,
                            size: 42,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : ReorderableGridView(
                scrollController: _scrollController,
                orderedIndexes: savedOrder,
                onOrderChange: (newOrderedList) {
                  savedOrder =
                      newOrderedList.map((e) => e!.orderNumber).toList();
                },
                children: [
                  cashboardItems[0] as ReorderableGridItem,
                  cashboardItems[1] as ReorderableGridItem,
                  cashboardItems[2] as ReorderableGridItem,
                  cashboardItems[3] as ReorderableGridItem,
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switchView();
        },
        child: const Icon(Icons.swap_horiz),
        backgroundColor: const Color(0xff5855DC),
      ),
    );
  }
}

class TheAnimatedContainer extends StatefulWidget {
  @override
  _TheAnimatedContainerState createState() => _TheAnimatedContainerState();
}

class _TheAnimatedContainerState extends State<TheAnimatedContainer> {
  bool _changeHeight = false;
  late Timer _everySecond;
  bool _timerStarted = false;

  void _startTimer() {
    if (_timerStarted == false) {
      _timerStarted = true;
      _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (mounted) {
          setState(() {
            _changeHeight = !_changeHeight;
          });
        }
      });
    }
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _everySecond.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      height: _changeHeight ? 75 : 150,
      margin: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Color(0xff5855DC)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Good luck",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 36),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.emoji_emotions_outlined,
              color: Colors.white,
              size: 42,
            ),
          ],
        ),
      ),
    );
  }
}
