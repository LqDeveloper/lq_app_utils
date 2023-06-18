import 'package:flutter/widgets.dart';

class KeyboardDismiss extends StatefulWidget {
  ///是否拦截点击事件隐藏键盘
  final bool dismissOnCapturedTaps;

  const KeyboardDismiss({
    Key? key,
    required this.child,
    this.dismissOnCapturedTaps = false,
  }) : super(key: key);

  final Widget child;

  @override
  State<KeyboardDismiss> createState() => _KeyboardDismissOnTapState();

  static void ignoreNextTap(BuildContext context) {
    context
        .dependOnInheritedWidgetOfExactType<
            _KeyboardDismissOnTapInheritedWidget>()!
        .ignoreNextTap();
  }
}

class _KeyboardDismissOnTapState extends State<KeyboardDismiss> {
  bool ignoreNextTap = false;

  void _hideKeyboard(BuildContext context) {
    if (ignoreNextTap) {
      ignoreNextTap = false;
    } else {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _KeyboardDismissOnTapInheritedWidget(
      ignoreNextTap: () {
        ignoreNextTap = true;
      },
      child: !widget.dismissOnCapturedTaps
          ? GestureDetector(
              onTap: () {
                _hideKeyboard(context);
              },
              child: widget.child,
            )
          : Listener(
              onPointerUp: (_) {
                _hideKeyboard(context);
              },
              behavior: HitTestBehavior.translucent,
              child: widget.child,
            ),
    );
  }
}

class IgnoreKeyboardDismiss extends StatelessWidget {
  final Widget child;

  const IgnoreKeyboardDismiss({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) {
        KeyboardDismiss.ignoreNextTap(context);
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}

class _KeyboardDismissOnTapInheritedWidget extends InheritedWidget {
  const _KeyboardDismissOnTapInheritedWidget({
    Key? key,
    required this.ignoreNextTap,
    required Widget child,
  }) : super(key: key, child: child);

  final VoidCallback ignoreNextTap;

  @override
  bool updateShouldNotify(_KeyboardDismissOnTapInheritedWidget oldWidget) {
    return false;
  }
}
