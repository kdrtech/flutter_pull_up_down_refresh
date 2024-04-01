// TODO: Put public facing types in this file.
import 'package:flutter/material.dart';

/// Checks if you are awesome. Spoiler: you are.
class FlutterPullUpDownRefresh extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool showRefreshIndicator;
  final Color? loadingColor;
  final Color? loadingBgColor;
  final Color? refreshIndicatorColor;
  final Function? onRefresh;
  final ScrollController? scrollController;
  final Function(bool)? onAtBottom;
  final Function(bool)? onAtTop;

  const FlutterPullUpDownRefresh({
    super.key,
    required this.scrollController,
    required this.child,
    this.loadingColor,
    this.loadingBgColor,
    this.refreshIndicatorColor,
    this.showRefreshIndicator = true,
    this.isLoading = false,
    this.onRefresh,
    this.onAtBottom,
    this.onAtTop,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IgnorePointer(
        ignoring: isLoading ? true : false,
        child: NotificationListener(
            onNotification: (notification) {
              if (scrollController != null) {
                try {
                  double pixels = scrollController!.position.pixels;
                  double maxScrollExtent =
                      scrollController!.position.maxScrollExtent;

                  if (pixels >= maxScrollExtent - 5) {
                    onAtBottom?.call(pixels > 0);
                  } else if (pixels <= 0) {
                    onAtTop?.call(pixels <= 0);
                  }
                } catch (err) {
                  //print(err);
                }
              }
              return false;
            },
            child: showRefreshIndicator
                ? RefreshIndicator(
                    color: refreshIndicatorColor ?? Colors.blue,
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    onRefresh: () async {
                      await onRefresh?.call();
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) => SingleChildScrollView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraints.maxHeight),
                          child: child,
                        ),
                      ),
                    ),
                  )
                : child),
      ),
      Visibility(
        visible: isLoading,
        child: Container(
          color: loadingBgColor ?? Colors.black.withOpacity(0.05),
          child: Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(loadingColor ?? Colors.blue),
            ),
          ),
        ),
      )
    ]);
  }
}

class Testing {
  bool isAwesome() {
    return true;
  }
}
