import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../controllers/repositories/user_repository.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit(this.userRepository) : super(AppointmentInitial());
  final UserRepository userRepository;

  void updateDate() {
    emit(AppointmentDateUpdate());
  }

  void updateTime() {
    emit(AppointmentTimeUpdate());
  }

  getAllDoctors() async {
    emit(AppointmentLoading());
    final response = await userRepository.getAllDoctors();
    response.fold(
      (errMessage) => emit(AppointmentFailure(errorMessage: errMessage)),
      (AppointmentModel) =>
          emit(AppointmentSuccess(successMessage: AppointmentModel.message)),
    );
  }
}
