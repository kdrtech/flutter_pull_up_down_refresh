// TODO: Put public facing types in this file.
import 'package:flutter/material.dart';

/// FlutterPullUpDownRefresh is the main class of the FlutterPullUpDownRefresh API.
///
/// It manages all params required for API using.
/// you can check some required, some not.
class FlutterPullUpDownRefresh extends StatelessWidget {
  /// The [child] from user input.
  ///
  /// Ex: Text(""), ListView.Build().
  final Widget child;

  /// The [isLoading] show progress loading view.
  ///
  /// The value true, false
  final bool isLoading;

  /// The [showRefreshIndicator] show indicator pull refresh.
  ///
  /// The value true, false
  final bool showRefreshIndicator;

  /// The [loadingColor] change loading colors.
  final Color? loadingColor;

  /// The [loadingBgColor] change backkground loading colors.
  final Color? loadingBgColor;

  /// The [refreshIndicatorColor] change indicator pull refresh  colors.
  final Color? refreshIndicatorColor;

  /// The [onRefresh] this for listen onRefresh function.
  final Function? onRefresh;

  /// The [scrollController] scrollcontroller class.
  final ScrollController? scrollController;

  /// The [scrollController] this for listen onAtBottom function.
  final Function(bool)? onAtBottom;

  /// The [scrollController] this for listen onAtTop function.
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
