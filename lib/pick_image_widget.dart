import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit_state.dart';

class PickImageWidget extends StatelessWidget {
  final File? uploadedImage;

  const PickImageWidget({
    Key? key,
    this.uploadedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final currentProfilePic = uploadedImage ?? userCubit.profilePic;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        final updatedProfilePic = state is UploadProfilePic
            ? state.profilePic
            : currentProfilePic;

        return SizedBox(
          width: 130,
          height: 130,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: updatedProfilePic != null
                    ? FileImage(updatedProfilePic) as ImageProvider
                    : const AssetImage("assets/images/skin doctor.png"),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () async {
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
        final file = File(pickedFile.path);
        final extension = pickedFile.path.split('.').last.toLowerCase();

        if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
        userCubit.uploadProfilePic(file); // الصيغة مدعومة، كمل
        } else {
        // اعرض رسالة للمستخدم إن الصيغة غير مدعومة
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى اختيار صورة بصيغة JPG أو PNG فقط')),
        );
        }
        }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.camera_alt_sharp,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
