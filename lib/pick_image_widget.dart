import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit_state.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({
    super.key,
  });

  @override

  /// A widget for picking an image.
  ///
  /// This widget contains a [CircleAvatar] for showing the current user's avatar
  /// and a [Stack] for positioning a camera icon at the bottom right of the
  /// avatar. When the icon is tapped, it opens the gallery for the user to
  /// pick an image.
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: 130,
          height: 130,
          child: context.read<UserCubit>().profilePic == null
              ? CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: const AssetImage("assets/images/avatar.png"),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () async {},
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                ImagePicker()
                                    .pickImage(source: ImageSource.gallery)
                                    .then((value) => context
                                        .read<UserCubit>()
                                        .uploadProfilePic(value!));
                              },
                              child: const Icon(
                                Icons.camera_alt_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : CircleAvatar(
                  backgroundImage: FileImage(
                      File(context.read<UserCubit>().profilePic!.path)),
                ),
        );
      },
    );
  }
}
