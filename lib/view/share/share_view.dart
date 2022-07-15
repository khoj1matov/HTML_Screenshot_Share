import 'package:example/core/constants/image_path_const.dart';
import 'package:example/view/share/image_preview_view.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SharePlusView extends StatefulWidget {
  const SharePlusView({Key? key}) : super(key: key);

  @override
  State<SharePlusView> createState() => _SharePlusViewState();
}

class _SharePlusViewState extends State<SharePlusView> {
  String text = '';
  String subject = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Plus Plugin Demo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ImagePreviews(
                ImagePathConst.imagePaths!,
                onDelete: _onDeleteImage,
              ),
              const Padding(padding: EdgeInsets.only(top: 12.0)),
              Builder(
                builder: (BuildContext context) {
                  return ElevatedButton(
                    onPressed:
                        text.isEmpty && ImagePathConst.imagePaths!.isEmpty
                            ? null
                            : () => _onShare(context),
                    child: const Text('Share'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDeleteImage(int position) {
    setState(() {
      ImagePathConst.imagePaths!.removeAt(position);
    });
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    if (ImagePathConst.imagePaths!.isNotEmpty) {
      await Share.shareFiles(
        ImagePathConst.imagePaths!,
        text: text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }
  }
}
