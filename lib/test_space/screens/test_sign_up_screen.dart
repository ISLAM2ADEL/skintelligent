import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_cubit.dart';
import '../repositories/user_repository.dart';
import 'package:dio/dio.dart';

class TestSignUpScreen extends StatefulWidget {
  const TestSignUpScreen({super.key});
  static String id = "TestSignUpScreen";

  @override
  State<TestSignUpScreen> createState() => _TestSignUpScreenState();
}

class _TestSignUpScreenState extends State<TestSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressController = TextEditingController();

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
        "confirmPassword": _confirmPasswordController.text.trim(),
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "dateOfBirth":
            DateTime.tryParse(_dobController.text)?.toIso8601String() ??
                DateTime.now().toIso8601String(),
        "gender": _genderController.text.trim(),
        "address": _addressController.text.trim(),
        "profilePicture":
            "http://skintelligent.runasp.net/image/doctorProfilePictures/default.jpg",
      };

      context.read<UserCubit>().signUp(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserCubit(userRepository: UserRepository(dio: Dio())),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email')),
                TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true),
                TextFormField(
                    controller: _confirmPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true),
                TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name')),
                TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name')),
                TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                        labelText: 'Date of Birth (YYYY-MM-DD)')),
                TextFormField(
                    controller: _genderController,
                    decoration: const InputDecoration(labelText: 'Gender')),
                TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Address')),
                const SizedBox(height: 20),
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is UserSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.model.message)),
                      );
                    } else if (state is UserFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${state.error}')),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () => _submit(context),
                      child: const Text('Register'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
