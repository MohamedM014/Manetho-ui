import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../view_model/main_cubit.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().uploadPicture(ImageSource.camera);
  }

  // File? _imageFile;
  // bool _pictureTaken = false;
  //
  // Future<void> _takePicture() async {
  //   if (_pictureTaken) {
  //     return; // Don't allow taking another picture if one has already been taken
  //   }
  //
  //   final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (imageFile != null) {
  //     final croppedImage = await ImageCropper().cropImage(
  //       sourcePath: imageFile.path,
  //       aspectRatioPresets: [CropAspectRatioPreset.square],
  //     );
  //
  //     if (croppedImage != null) {
  //       setState(() {
  //         _imageFile = File(croppedImage.path);
  //         _pictureTaken = true;
  //       });
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => const LayoutScreen(),
  //         ),
  //       );
  //     }
  //   } else {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => const LayoutScreen(),
  //       ),
  //     ); // If no picture is taken, return to the home page
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // _takePicture();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xff724B27), Color(0xff171715)])),
      ),

    );
  }
}