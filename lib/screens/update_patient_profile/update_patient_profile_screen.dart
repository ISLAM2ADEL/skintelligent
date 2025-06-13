

//-------------- Updated code [download image and cache not download it locallly ] --------------
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_cubit.dart';
import 'package:skintelligent/cubit/update_patient_profile_cubit/update_patient_profile_cubit.dart';
import 'package:skintelligent/cubit/update_patient_profile_cubit/update_patient_profile_state.dart';

class UpdatePatientProfileScreen extends StatefulWidget {
  const UpdatePatientProfileScreen({super.key});
  static const String id = 'UpdatePatientProfileScreen';

  @override
  State<UpdatePatientProfileScreen> createState() =>
      _UpdatePatientProfileScreenState();
}

class _UpdatePatientProfileScreenState
    extends State<UpdatePatientProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UpdatePatientProfileCubit>().fetchAndFillPatientProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      body: BlocConsumer<UpdatePatientProfileCubit, UpdatePatientProfileState>(
        listener: (context, state) {
          if (state is UpdatePatientProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            context.read<PatientProfileCubit>().getPatientProfile();
            Navigator.pop(context);
          } else if (state is UpdatePatientProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.watch<UpdatePatientProfileCubit>();

          if (state is UpdatePatientProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: cubit.pickImage,
                  child: cubit.profilePic != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(cubit.profilePic!),
                        )
                      : (cubit.existingProfileImageUrl != null &&
                              cubit.existingProfileImageUrl!.isNotEmpty)
                          ? CachedNetworkImage(
                              imageUrl: cubit.existingProfileImageUrl!,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 50,
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) => const CircleAvatar(
                                radius: 50,
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                    "assets/images/default_image.png"),
                              ),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/images/default_image.png"),
                            ),
                ),
                const SizedBox(height: 16),
                _buildTextField(cubit.signUpFirstName, 'First Name'),
                _buildTextField(cubit.signUpLastName, 'Last Name'),
                _buildTextField(cubit.signUpPhoneNumber, 'Phone'),
                _buildTextField(cubit.signUpAddress, 'Address'),
                _buildTextField(cubit.dateOfBirth, 'Date of Birth'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: cubit.updatePatientProfile,
                  child: state is UpdatePatientProfileLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Update Profile'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
