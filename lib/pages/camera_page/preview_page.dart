import 'package:geolocator/geolocator.dart';
import 'package:photo_sender/api_statuses/api_failure.dart';
import 'package:photo_sender/api_statuses/api_success.dart';
import 'package:photo_sender/datasources/image_upload_datasource.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photo_sender/utils/language_util.dart';
import 'package:photo_sender/voids/voids.dart';

late List<CameraDescription> cameras;

class PreviewPage extends StatefulWidget {
  final String? imagePath;

  const PreviewPage({Key? key, this.imagePath})
      : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {

  late final CameraController controller;
  late LocationPermission permission;

  TextEditingController commentController = TextEditingController();
  ImageUploadDatasource uploadDatasource = ImageUploadDatasource();

  bool _isCameraReady = false;

  XFile? image;
  String path = '';


  @override
  void initState() {
    super.initState();
    _setupCamera();
    _setupLocationPermission();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _setupLocationPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if(context.mounted) {
          showSnackBar(LanguageUtil.locationPermissionDenied, context);
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if(context.mounted) {
        showSnackBar(LanguageUtil.locationPermissionsArePermanentlyDenied, context);
      }
    }
  }

  Future<void> _setupCamera() async {
    try {
      controller =  CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch (e) {
        switch (e.code) {
          case 'CameraAccessDenied':
            showSnackBar(LanguageUtil.pleaseEnableAccessForCamera, context);
            break;
          default:
            showSnackBar(LanguageUtil.somethingWentWrongWithCamera, context);
            break;
      }
    }
    if (!mounted) return;
    setState(() {
      _isCameraReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraReady) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: 350,
              width: double.infinity,
              child: CameraPreview(controller)
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: LanguageUtil.enterCommentForPhoto
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  await sendPhoto(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Icon(
                        Icons.camera_alt,
                        size: 35,
                      ),
                    ),
                    Text(
                        'Send photo',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendPhoto(BuildContext context) async {
    try {
      final xFile = await controller.takePicture();
      path = xFile.path;

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      try {
        var response = await uploadDatasource.uploadImage(
            photoPath: path,
            comment: commentController.value.text,
            position: position,
        );

        if(response is ApiSuccess) {
          if (context.mounted) showSnackBar(LanguageUtil.photoSent, context);
        }
      } on ApiFailure catch (e) {
        if(context.mounted) showSnackBar(e.errorResponse, context);
      } catch (e) {
        if(context.mounted) showSnackBar(e.toString(), context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
}