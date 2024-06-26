<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# flutter_pull_up_down_refresh

[![Pub Package](https://img.shields.io/pub/v/flutter_pull_up_down_refresh.svg?style=flat-square)](https://pub.dev/packages/flutter_pull_up_down_refresh)

<a  href="https://www.buymeacoffee.com/kdrtech" target="_blank">
<img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" height="41" />
</a>

Highly video, feature-packed flutter_pull_up_down_refresh widget for Flutter.

| ![Image](https://raw.githubusercontent.com/kdrtech/flutter_pull_up_down_refresh/master/example/assets/dummy/screen-v1.0.4.gif)
| :------------: |
| **flutter_pull_up_down_refresh** |



 
## Features

* Pull Down to refresh data
* Pull Up to reload new data.
* Allow show refresh indicator
* Change loading color
* Change background loading color
* Change refresh indicator Color 
* Show bottom loading.
* Scale  bottom loading size.
* change color loading option.

## Usage

Make sure to check out [examples](https://github.com/kdrtech/flutter_pull_up_down_refresh/tree/master/example/lib)

### Installation

Add the following line to `pubspec.yaml`:

```yaml
dependencies:
  flutter_pull_up_down_refresh: ^1.0.4
```

### Basic setup

*The complete example is available [here](https://github.com/kdrtech/flutter_pull_up_down_refresh/tree/master/example/lib).*

```dart
FlutterPullUpDownRefresh(
      scrollController: ScrollController(),
      showRefreshIndicator: true,
      refreshIndicatorColor: Colors.red,
      isLoading: isLoading,
      loadingColor: Colors.red,
      loadingBgColor: Colors.grey.withAlpha(100),
      isBootomLoading: isBottom,
      bottomLoadingColor: Colors.green,
      scaleBottomLoading: 0.6,
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
            child: Text("item")
        )
      }
    )
)
```

*** Note *** if use child as Listview please don't forget add this option to disabled listview scroll.
```yaml
ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
)
```

### Events

use `onRefresh` to refesh data 

```dart
onRefresh: () async {
  //Start refresh
  await pullRefresh();
  //End refresh
},
```
use `onAtBottom` to reload new data 

```dart
onAtBottom: (status) {
  //do something
},
```

use `onAtTop` to optional event just let you know , scroll stay on top. 

```dart
onAtTop: (status) {
   //do something
},
```
Hello everyone 👋

If you want to support me, feel free to do so. 

Thanks

============================================

សួស្ដី អ្នកទាំងអស់គ្នា👋 

បើ​អ្នក​ចង់​គាំទ្រ​ខ្ញុំ សូម​ធ្វើ​ដោយ​សេរី , 

សូមអរគុណ

<a  href="https://www.buymeacoffee.com/kdrtech" target="_blank">
<img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" height="41" />
</a>
