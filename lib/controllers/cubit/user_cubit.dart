import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:skintelligent/commons.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();
  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //Profile Pic
  XFile? profilePic;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  SigninModel? user;
  signin() async {
    try {
      emit(SigninLoading());
      final response = await api.post(
        Endpoint.signIn,
        data: {
          ApiKey.email: signInEmail.text,
          ApiKey.password: signInPassword.text
        },
      );
      user = SigninModel.fromJson(response.data);
      // final decodedToken = JwtDecoder.decode(user!.token);
      // print("the token is ${decodedToken[ApiKey.id]}");
      await getIt<CacheHelper>()
          .saveData(key: ApiKey.token, value: user!.data.token);
      await getIt<CacheHelper>()
          .saveData(key: ApiKey.id, value: user!.data.id);
      emit(SigninSuccess(successMessage:  user!.message));
    } on ServerException catch (e) {
      emit(SigninFailure(errorMessage: e.errorModel.errorMessage));
    }
  }

  signup() async {
    try {
      emit(SignupLoading());
      final response = await api.post(Endpoint.signUp, isFormData: true, data: {
        ApiKey.name: signUpName.text,
        ApiKey.email: signUpEmail.text,
        ApiKey.password: signUpPassword.text,
        ApiKey.phone: signUpPhoneNumber.text,
        ApiKey.confirmPassword: confirmPassword.text,
        ApiKey.location:
            '{"name":"methalfa","address": "meet halfa","coordinates": [30.1572709, 31.224779]}',
        ApiKey.profilePic: await uploadImageToApi(profilePic!),
      });
      final signupModel = SignupModel.fromJson(response.data);
      emit(SignupSuccess(message: signupModel.message));
    } on ServerException catch (e) {
      emit(SignupFailure(errorMessage: e.errorModel.errorMessage));
    }
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  getUserProfile() async {
    try {
      emit(GetUserProfileLoading());
      final response = await api.get(Endpoint.getUserDataEndPoint(
          await getIt<CacheHelper>().getData(key: ApiKey.id)));
      print('response is ${response.data}');
      emit(GetUserProfileSuccess(user: UserModel.fromJson(response.data)));
    } on ServerException catch (e) {
      emit(GetUserProfileFailure(errorMessage: e.errorModel.errorMessage));
    }
  }
}
