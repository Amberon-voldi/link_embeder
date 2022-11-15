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

### Link Embeder

Link embeder for flutter, scrapes URLs from text and shows a Embed with metaData (eg. title, image, description etc..)

## Features

show clickable link embed widget with metaData from the website

## Getting started

To use the package see and example in the example tab

```dart
 String Text =
      'Hey there! I just found out this cool link: https://flutter.dev';

  @override
  Widget build(BuildContext context) {
    return Container(
      //Provide context and text to the LinkEmbeder widget
      //The LinkEmbeder widget will return a widget with the embedded conte
      //(eg. title, description, image, etc.)
      child: LinkEmbeder().showEmbed(context, Text),
    );
  }
}
```

## Additional information

If you guys have any issue or want to contribute to this package, you can visit the github repo.
