import 'package:flutter/material.dart';

class BottomNavUtils {
  BottomNavUtils._();

  static final BottomNavController _controller = BottomNavController();

  static BottomNavController get controller => _controller;

  static void jumpTo(int index, {Object? arguments}) {
    _controller.jumpTo(index);
  }
}

class BottomNavController {
  BottomNavBarState? _state;

  void jumpTo(int index) {
    _state?._jumpToIndex(index);
  }

  void _dispose() {
    _state = null;
  }
}

typedef BottomNavItemBuilder = Widget Function(
    BuildContext context, int index, bool isSelected);
typedef BottomNavIndexChanged = void Function(int from, int to);

class BottomNavBar extends StatefulWidget {
  final BottomNavController? controller;
  final int initialIndex;
  final List<Widget> pages;
  final List<String> itemLabels;
  final BottomNavItemBuilder itemBuilder;
  final BottomNavIndexChanged? onPageChanged;
  final BottomNavigationBarThemeData? data;

  const BottomNavBar({
    Key? key,
    this.controller,
    this.initialIndex = 0,
    required this.pages,
    required this.itemLabels,
    required this.itemBuilder,
    this.onPageChanged,
    this.data,
  })  : assert(pages.length == itemLabels.length, 'item的数量和page的数量不一致'),
        assert(initialIndex >= 0 && initialIndex < pages.length,
            'initialIndex设置不合法'),
        super(key: key);

  static BottomNavBarState? maybeOf(BuildContext context) {
    BottomNavBarState? state =
        context.findAncestorStateOfType<BottomNavBarState>();
    return state;
  }

  static BottomNavBarState of(BuildContext context) {
    BottomNavBarState? state = maybeOf(context);
    assert(state != null, '使用的context无法找到BottomNavBarState');
    return state!;
  }

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  PageController? _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    widget.controller?._state = this;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      _currentIndex = widget.initialIndex;
      _jumpToIndex(_currentIndex);
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._dispose();
      widget.controller?._state = this;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomNavigationBarTheme: widget.data,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView.builder(
          controller: _pageController,
          itemCount: widget.pages.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => widget.pages[index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: List.generate(widget.itemLabels.length, (index) {
            final label = widget.itemLabels[index];
            return BottomNavigationBarItem(
              label: label,
              icon: widget.itemBuilder(context, index, _currentIndex == index),
            );
          }),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            _jumpToIndex(index);
          },
        ),
      ),
    );
  }

  void _jumpToIndex(int index) {
    if (index < 0 || index >= widget.pages.length) {
      return;
    }
    if (_currentIndex != index) {
      final from = _currentIndex;
      setState(() {
        _currentIndex = index;
      });
      _pageController?.jumpToPage(index);
      widget.onPageChanged?.call(from, index);
    }
  }
}
