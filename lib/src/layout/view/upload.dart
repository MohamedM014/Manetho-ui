import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mannetho/src/layout/view_model/main_cubit.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<Upload> {

  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().uploadPicture(ImageSource.gallery);
  }


  @override
  Widget build(BuildContext context) {
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