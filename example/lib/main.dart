// Copyright 2022 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a MIT license that can be found  in the LICENSE file.

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:link_embeder/link_embeder.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

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
