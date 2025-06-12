import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:skintelligent/commons.dart';
import 'package:skintelligent/controllers/api/dio_consumer.dart';
import 'package:skintelligent/controllers/repositories/user_repository.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_cubit.dart';

final getIt = GetIt.instance;
void setputServiceLocator() {
  UserRepository userRepository = UserRepository(api: DioConsumer(dio: Dio()));
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerSingleton<PatientProfileCubit>(
      PatientProfileCubit(userRepository));
}
