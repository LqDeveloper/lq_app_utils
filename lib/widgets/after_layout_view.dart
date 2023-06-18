import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

typedef AfterLayoutCallback = Function(RenderAfterLayout ral);

///在布局结束后，获取对应的RenderObject对象
class AfterLayoutView extends SingleChildRenderObjectWidget {
  const AfterLayoutView({
    Key? key,
    required this.callback,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderAfterLayout(callback);
  }

  @override
  void updateRenderObject(context, RenderAfterLayout renderObject) {
    renderObject.callback = callback;
  }

  final AfterLayoutCallback callback;
}

class RenderAfterLayout extends RenderProxyBox {
  RenderAfterLayout(this.callback);

  ValueSetter<RenderAfterLayout> callback;

  @override
  void performLayout() {
    super.performLayout();
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => callback(this));
  }

  /// 组件在在屏幕坐标中的起始偏移坐标
  Offset get offset => localToGlobal(Offset.zero);

  /// 组件在屏幕上占有的矩形空间区域
  Rect get rect => offset & size;
}
