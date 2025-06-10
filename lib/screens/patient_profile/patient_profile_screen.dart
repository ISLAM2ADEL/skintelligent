import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_cubit.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_state.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});
  static const String id = 'PatientProfileScreen';
  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Call the cubit function to fetch patient profile when the screen is initialized
    BlocProvider.of<PatientProfileCubit>(context).getPatientProfile();
  }

  @override
  Widget build(BuildContext context) {
    // Call the cubit's function when screen is built

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to update screen or show dialog
              // Navigator.pushNamed(context, EditProfileScreen.id);
              _showUpdateDialog();
            },
          ),
        ],
      ),
      body: BlocListener<PatientProfileCubit, PatientProfileState>(
        listener: (context, state) {
          if (state is PatientProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.errMessage}")),
            );
          }
        },
        child: BlocBuilder<PatientProfileCubit, PatientProfileState>(
          builder: (context, state) {
            if (state is PatientProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PatientProfileSuccess) {
              final patient = state.patientModel;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    if (patient.profilePicture.isNotEmpty)
                      // CircleAvatar(
                      //   radius: 100,
                      //   backgroundImage: NetworkImage(patient.profilePicture),
                      // ),
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: ClipOval(
                            child: Image.network(
                              patient.profilePicture,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset("assets/images/default_image.png",
                                      fit: BoxFit.cover),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      "${patient.firstName} ${patient.lastName}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _profileField("Email", patient.email),
                    _profileField(
                        "Phone",
                        patient.phone.trim().isNotEmpty
                            ? patient.phone.trim()
                            : "N/A"),
                    _profileField("Gender", patient.gender),
                    _profileField(
                      "Date of Birth",
                      patient.dateOfBirth.toLocal().toString().split(' ')[0],
                    ),
                    _profileField("Address", patient.address),
                  ],
                ),
              );
            }

            return const SizedBox(); // initial or fallback state
          },
        ),
      ),
    );
  }

  Widget _profileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Profile'),
          content: const Text('This feature is under development.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
