import 'dart:io';
import 'dart:typed_data';

import 'package:example/core/constants/html_code_const.dart';
import 'package:example/core/constants/image_path_const.dart';
import 'package:example/view/share/share_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

ScreenshotController screenshotController = ScreenshotController();

class _HomeViewState extends State<HomeView> {
  Uint8List? _imageFile;
  Future<Directory?>? _appDocumentsDirectory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter HTML Example'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.camera_alt_outlined),
          onPressed: () {
            screenshotController.capture().then((image) {
              const Duration(seconds: 2);
              setState(() {
                _imageFile = image;
                // Directory appDocDir = await getApplicationDocumentsDirectory();
                // ImagePathConst.imagePaths = [appDocDir.path];
              });
            }).catchError((onError) => print("onError"));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SharePlusView()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: () {},
          )
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Html(
                data: CodeHTML.htmlData,
              ),
              _imageFile == null
                  ? const Text("Null")
                  : Image.memory(_imageFile!),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showCapturedWidget(
    BuildContext context,
    Uint8List capturedImage,
  ) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text("Captured widget screenshot"),
        ),
        body: Center(
          child:
              capturedImage != null ? Image.memory(capturedImage) : Container(),
        ),
      ),
    );
  }
}
