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
  late UpdatePatientProfileCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<UpdatePatientProfileCubit>();
    cubit.fetchAndFillPatientProfile();
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
          if (state is UpdatePatientProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final imageProvider = cubit.profilePic != null
              ? FileImage(cubit.profilePic!)
              : const AssetImage('assets/images/default_image.png')
                  as ImageProvider;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => cubit.pickImage(),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: imageProvider,
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
                      ? const CircularProgressIndicator()
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
