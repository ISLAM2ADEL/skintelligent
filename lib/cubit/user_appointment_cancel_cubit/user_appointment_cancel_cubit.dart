import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/user_appointment_cancel_cubit/user_appointment_cancel_state.dart';

class UserAppointmentCancelCubit extends Cubit<UserAppointmentCancelState> {
  final UserRepository repository;

  UserAppointmentCancelCubit(this.repository)
      : super(UserAppointmentCancelInitial());

  Future<void> fetchCancelAppointments({required int appointmentId}) async {
    emit(UserAppointmentCancelLoading());
    final response = await repository.cancelBooking(
      appointmentId: appointmentId,
    );
    response.fold(
      (error) => emit(UserAppointmentCancelFailure(error)),
      (cancelModel) => emit(UserAppointmentCancelSuccess(cancelModel)),
    );
  }
}
