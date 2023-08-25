import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:photo_sender/pages/camera_page/camera_page.dart';
import 'package:photo_sender/pages/camera_page/preview_page.dart';
import 'package:photo_sender/utils/language_util.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Geolocator.requestPermission();
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: LanguageUtil.photoSender,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CameraPage(title: LanguageUtil.photoSender),
    );
  }
}

