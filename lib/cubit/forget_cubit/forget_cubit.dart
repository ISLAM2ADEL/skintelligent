import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skintelligent/models/forget_model.dart';

import '../../commons.dart';
import '../../controllers/api/api_consumer.dart';
import '../../controllers/api/endpoint.dart';

part 'forget_state.dart';

class ForgetCubit extends Cubit<ForgetState> {
  ForgetCubit(this.api) : super(ForgetInitial());
  final ApiConsumer api;

  GlobalKey<FormState> forgetFormKey = GlobalKey();
  TextEditingController forgetEmail = TextEditingController();
  ForgetModel? user;

  forgetPassword() async {
    try {
      emit(ForgetLoading());
      final response = await api.post(
        Endpoint.forgetPassword,
        data: {
          ApiKey.email: forgetEmail.text,
        },
      );
      user = ForgetModel.fromJson(response.data);
      emit(ForgetSuccess(successMessage: user!.message));
    } on ServerException catch (e) {
      emit(ForgetFailure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      // Handle any other unexpected errors
      emit(ForgetFailure(errorMessage: 'An unexpected error occurred.'));
      debugPrint("ForgetCubit error: $e"); // Optional for debugging
    }
  }
}
