import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pull_up_down_refresh/flutter_pull_up_down_refresh.dart';

import 'file_manager.dart';
import 'product.dart';

class FlutterPullUpDownRefreshExample extends StatefulWidget {
  const FlutterPullUpDownRefreshExample({
    super.key,
  });

  @override
  FlutterPullUpDownRefreshExampleState createState() =>
      FlutterPullUpDownRefreshExampleState();
}

class FlutterPullUpDownRefreshExampleState
    extends State<FlutterPullUpDownRefreshExample> {
  bool isLoading = false;
  bool isRefresh = true;
  bool isBottom = false;

  List<Product> lists = [];
  int startIndex = 0;
  int endIndex = 5;

  Future pullRefresh() async {
    isLoading = true;
    setState(() {});
    startIndex = 0;
    endIndex = 5;
    var data = await FileManager.share.readJson(fileName: "data.json");
    var list = (data as List).map((e) => Product.fromJson(e)).toList();
    var sub = list.sublist(startIndex, endIndex);
    await Future.delayed(const Duration(seconds: 1));
    lists = [];
    lists.addAll(sub);
    isLoading = false;
    isRefresh = false;
    setState(() {});
  }

  Future listItem() async {
    var data = await FileManager.share.readJson(fileName: "data.json");
    var list = (data as List).map((e) => Product.fromJson(e)).toList();
    await Future.delayed(const Duration(seconds: 1));
    if (endIndex >= list.length) {
      return;
    }
    var sub = list.sublist(startIndex, endIndex);
    lists.addAll(sub);
    isLoading = false;
    isRefresh = false;
    isBottom = false;
    setState(() {
      startIndex = endIndex;
      endIndex += 5;
    });
  }

  @override
  void initState() {
    listItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterPullUpDownRefresh(
      scrollController: ScrollController(),
      showRefreshIndicator: true,
      refreshIndicatorColor: Colors.red,
      isLoading: isLoading,
      loadingColor: Colors.red,
      loadingBgColor: Colors.grey.withAlpha(100),
      onRefresh: () async {
        //Start refresh
        await pullRefresh();
        //End refresh
      },
      onAtBottom: (status) {
        if (status) {
          if (kDebugMode) {
            print("Scroll at bottom");
            if (!isBottom) {
              isBottom = true;
              listItem();
            }
          }
        }
      },
      onAtTop: (status) {
        if (kDebugMode) {
          print("Scroll at Top");
        }
      },
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: lists.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 5,
              top: 5,
            ),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR83JIYLcgFML0SMBd_K1EQGlsPCLLt7hog6CKFG1IRYA&s',
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Android Small Removable Sticker Sheet",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 5),
                              child: Text(
                                'sfd',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Text(
                              "\$51.99",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
