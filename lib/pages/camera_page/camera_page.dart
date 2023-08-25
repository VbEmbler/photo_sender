import 'package:flutter/material.dart';
import 'package:photo_sender/pages/camera_page/preview_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.title});

  final String title;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MediaQuery.of(context).orientation == Orientation.portrait
            ? AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(widget.title),
                centerTitle: true,
              )
            : null,
        body: const PreviewPage());
  }
}
