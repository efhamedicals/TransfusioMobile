import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/helpers/image_picker_helper.dart';

class UploadImageWidget extends StatefulWidget {
  final Function(File?) onImageSelected;
  final File? initialValue;
  final String title;
  final double? height;
  const UploadImageWidget({
    super.key,
    required this.onImageSelected,
    this.initialValue,
    required this.title,
    this.height = 400,
  });

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  File? fileUploaded;

  @override
  void initState() {
    super.initState();
    fileUploaded = widget.initialValue;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child:
          fileUploaded == null
              ? GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  height: widget.height,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Dimensions.verticalSpacer(10),
                      const Text(
                        "Taille maximale : 5 mb",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )
              : Card(
                child: Container(
                  height: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(fileUploaded!),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              fileUploaded = null;
                            });
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Téléverser une photo'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void pickImage(ImageSource source) async {
    final selectedImage = await ImagePickerHelper.choosePhoto(source);
    setState(() {
      fileUploaded = selectedImage;
    });

    widget.onImageSelected(fileUploaded);
  }
}
