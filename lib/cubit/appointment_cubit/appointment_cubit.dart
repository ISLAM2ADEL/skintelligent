import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../controllers/repositories/user_repository.dart';
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
          (appointment) {
        emit(AppointmentSuccess(
          successMessage: appointment.message,
          doctors: appointment.doctors,
          count: appointment.count,
        ));
      },
    );
  }

  Future<void> getAllDoctorsSortLocally(String sortBy, String sortOrder) async {
    emit(AppointmentSortLoading());
    final response = await userRepository.getAllDoctors(); // بدون أي sorting من الـ API

    response.fold(
          (errMessage) => emit(AppointmentSortFailure(errorMessage: errMessage)),
          (appointment) {
        List<DoctorModel> sortedDoctors = [...appointment.doctors];

        if (sortBy == 'name') {
          sortedDoctors.sort((a, b) => sortOrder == 'asc'
              ? a.firstName.compareTo(b.firstName)
              : b.firstName.compareTo(a.firstName));
        } else if (sortBy == 'experience') {
          sortedDoctors.sort((a, b) => sortOrder == 'asc'
              ? a.experienceYears.compareTo(b.experienceYears)
              : b.experienceYears.compareTo(a.experienceYears));
        } else if (sortBy == 'cost') {
          sortedDoctors.sort((a, b) => sortOrder == 'asc'
              ? a.defaultExaminationFee.compareTo(b.defaultExaminationFee)
              : b.defaultExaminationFee.compareTo(a.defaultExaminationFee));
        }

        emit(AppointmentSortSuccess(
          successMessage: appointment.message,
          doctors: sortedDoctors,
          count:appointment.count,
        ));
      },
    );
  }

}
