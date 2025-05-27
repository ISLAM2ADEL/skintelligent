import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../controllers/repositories/user_repository.dart';
// import '../../models/appointment_model.dart';
import '../../models/doctor_model.dart';
part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final UserRepository userRepository;

  AppointmentCubit(this.userRepository) : super(AppointmentInitial());

  void updateDate() => emit(AppointmentDateUpdate());

  void updateTime() => emit(AppointmentTimeUpdate());

  Future<void> getAllDoctors() async {
    emit(AppointmentLoading());
    final response = await userRepository.getAllDoctors();
    response.fold(
      (errMessage) => emit(AppointmentFailure(errorMessage: errMessage)),
      (appointment) => emit(AppointmentSuccess(
        successMessage: appointment.message,
        doctors: appointment.doctors,
      )),
    );
  }
}
