import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transfusio/src/core/assets/app_assets.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/core/utils/constants/app_dimensions.dart';
import 'package:transfusio/src/core/utils/constants/app_strings.dart';
import 'package:transfusio/src/core/utils/helpers/image_picker_helper.dart';

class UpdateAvatar extends StatefulWidget {
  final Function(File?) onImageSelected;
  final String? urlImage;
  const UpdateAvatar({super.key, required this.onImageSelected, this.urlImage});

  @override
  State<UpdateAvatar> createState() => _UpdateAvatarState();
}

class _UpdateAvatarState extends State<UpdateAvatar> {
  File? userAvatar;

  @override
  Widget build(BuildContext context) {
    var width = Dimensions.getScreenWidth(context);
    var height = Dimensions.getScreenHeight(context);
    return Center(
      child: Stack(
        children: <Widget>[
          userAvatar == null
              ? widget.urlImage == null
                  ? CircleAvatar(
                    radius: width < height ? width / 7 : height / 7,
                    backgroundImage: const AssetImage(AppAssets.defaultAvatar),
                    backgroundColor: Colors.white,
                  )
                  : CachedNetworkImage(
                    imageUrl: baseUrl + widget.urlImage!,
                    errorWidget:
                        (context, url, error) => Container(
                          height: width < height ? width / 4 : height / 4,
                          width: width < height ? width / 4 : height / 4,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(AppAssets.defaultAvatar),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(),
                        ),
                    imageBuilder:
                        (context, imageProvider) => Container(
                          height: width < height ? width / 4 : height / 4,
                          width: width < height ? width / 4 : height / 4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(),
                        ),
                  )
              : Container(
                height: width < height ? width / 4 : height / 4,
                width: width < height ? width / 4 : height / 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: FileImage(userAvatar!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          Positioned(
            bottom: 5,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondaryColor,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.camera,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
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
      userAvatar = selectedImage;
    });

    widget.onImageSelected(userAvatar);
  }
}
