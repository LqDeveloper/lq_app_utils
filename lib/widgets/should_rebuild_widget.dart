import 'package:flutter/material.dart';

typedef ShouldRebuildCallback = bool Function(
    Widget? oldWidget, Widget newWidget);

class ShouldRebuildWidget extends StatefulWidget {
  final Widget child;
  final ShouldRebuildCallback? shouldRebuild;

  const ShouldRebuildWidget(
      {super.key, required this.child, this.shouldRebuild});

  @override
  State<ShouldRebuildWidget> createState() => _ShouldRebuildState();
}

class _ShouldRebuildState extends State<ShouldRebuildWidget> {
  Widget? _oldWidget;

  @override
  Widget build(BuildContext context) {
    final Widget newWidget = widget.child;
    final shouldRebuild = widget.shouldRebuild == null
        ? true
        : (widget.shouldRebuild?.call(_oldWidget, newWidget) ?? true);
    if (shouldRebuild) {
      _oldWidget = newWidget;
    }
    return _oldWidget ?? newWidget;
  }
}
