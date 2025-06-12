import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:skintelligent/models/available_booking_model.dart';
import 'package:skintelligent/models/doctor_model.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit.dart';
import 'package:skintelligent/cubit/doctor_cubit/doctor_cubit_state.dart';
import 'package:skintelligent/cubit/make_booking_cubit/make_booking_cubit.dart';
import 'package:skintelligent/cubit/make_booking_cubit/make_booking_state.dart';
import 'package:skintelligent/cubit/available_booking_cubit/available_booking_cubit.dart';

import '../../controllers/api/endpoint.dart';
import '../../controllers/cache/cache_helper.dart';
import '../../services/service_locator.dart';
import '../../widgets/doctor_info_card.dart';
import '../../widgets/review_buttons.dart';
import '../../widgets/week_selector.dart';
import '../../widgets/booking_section.dart';
import '../ChatbotScrean/chatbotScreen.dart';
Future<void> pickAndUploadImage(int appointmentId, BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  XFile? pickedFile;

  while (pickedFile == null) {
    pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile == null) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text("Image is REQUIRED"),
            content: const Text("You should take the image for appointment process to succeed"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Take Image"),
              ),
            ],
          ),
        ),
      );
    }
  }

  File imageFile = File(pickedFile.path);

  String token = getIt<CacheHelper>().getData(key: ApiKey.Authorization);
  final formData = FormData.fromMap({
    'AppointmentId': appointmentId,
    'ImageFile': await MultipartFile.fromFile(
      imageFile.path,
      filename: imageFile.path.split('/').last,
      contentType: MediaType('image', 'jpeg'),
    ),
  });

  final dio = Dio();
  print('📦 Uploading with appointmentId: $appointmentId');
  print('📦 Image file path: ${imageFile.path}');

  try {
    final response = await dio.post(
      'http://skintelligent.runasp.net/api/chats/upload-image',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    print('✅ Response: ${response.statusCode} => ${response.data}');
    Navigator.pushReplacementNamed(
      context,
      Chatbotscreen.id,
      arguments: {
        "appointmentID": appointmentId,
        "patientID": 9
      },
    );
  } on DioException catch (e) {
    print('❌ Dio Error: ${e.response?.statusCode} => ${e.response?.data}');
  } catch (e) {
    print('❌ General Error: $e');
  }
}

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({
    super.key,
    required this.doctorId,
    required this.clinicId,
  });

  final int doctorId;
  final int clinicId;

  @override
  State<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  late DateTime selectedWeekStart;
  late List<DateTime> visibleWeekStartDates;
  DoctorModel? doctor;
  Map<String, List<Session>>? cachedWeeklySlots;
  int weekOffset = 0;

  static const int numberOfVisibleWeeks = 4;

  @override
  void initState() {
    super.initState();
    selectedWeekStart = _getStartOfWeek(DateTime.now());
    visibleWeekStartDates =
        _generateWeekStartDates(weekOffset, numberOfVisibleWeeks);
    _fetchDoctorAndBookings();
  }

  void _fetchDoctorAndBookings() {
    context.read<DoctorCubit>().getDoctorProfile(widget.doctorId);
    _fetchAvailableBookings();
  }

  void _fetchAvailableBookings() {
    context.read<AvailableBookingCubit>().getAvailableBookings(
          date: DateFormat('yyyy-MM-dd').format(selectedWeekStart),
          clinicId: widget.clinicId,
          doctorId: widget.doctorId,
        );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));

    _fetchDoctorAndBookings();
  }

  DateTime _getStartOfWeek(DateTime date) =>
      date.subtract(Duration(days: date.weekday % 7));

  List<DateTime> _generateWeekStartDates(int offset, int count) {
    final base =
        _getStartOfWeek(DateTime.now().add(Duration(days: offset * 7)));
    return List.generate(count, (i) => base.add(Duration(days: i * 7)));
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedWeekStart = date;
      _fetchAvailableBookings();
    });
  }

  void _onWeekChange(int direction) {
    setState(() {
      weekOffset += direction;
      visibleWeekStartDates =
          _generateWeekStartDates(weekOffset, numberOfVisibleWeeks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Doctor Info', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: BlocListener<MakeBookingCubit, MakeBookginState>(
        listener: (context, state) async {
          final messenger = ScaffoldMessenger.of(context);
          if (state is BookingSuccess) {
            messenger.showSnackBar(
              const SnackBar(
                content: Text("✅ Booking successful!"),
                duration: Duration(seconds: 2),
              ),
            );
            await pickAndUploadImage(state.appointmentId,context);
          } else if (state is BookingFailure) {
            messenger.showSnackBar(
              SnackBar(
                content: Text("❌ ${state.errMessage}"),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            if (state is GetDoctorLoading && doctor == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetDoctorFailure) {
              return Center(
                child: Text("Error: ${state.errMessage}",
                    style: const TextStyle(color: Colors.red)),
              );
            }

            if (state is GetDoctorSuccess) {
              doctor = state.doctor;
            }

            if (doctor == null) return const SizedBox.shrink();

            return RefreshIndicator(
              color: Colors.blue,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorInfoCard(doctor: doctor!),
                    const SizedBox(height: 30),
                    ReviewButtons(
                        doctorId: widget.doctorId, clinicId: widget.clinicId),
                    const SizedBox(height: 30),
                    WeekSelector(
                      selectedDate: selectedWeekStart,
                      dates: visibleWeekStartDates,
                      onDateSelected: _onDateSelected,
                      onNextPressed: () => _onWeekChange(1),
                      onBackPressed: () => _onWeekChange(-1),
                    ),
                    const SizedBox(height: 10),
                    BookingSection(
                      cachedWeeklySlots: cachedWeeklySlots,
                      onCacheUpdate: (slots) {
                        setState(() {
                          cachedWeeklySlots = slots;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
