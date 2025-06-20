import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_cubit.dart';
import 'package:skintelligent/cubit/update_patient_profile_cubit/update_patient_profile_cubit.dart';
import 'package:skintelligent/cubit/user_cubit/user_cubit.dart';
import 'package:skintelligent/cubit/patient_profile_cubit/patient_profile_state.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<UserCubit>().signInEmail.clear();
        context.read<UserCubit>().signInPassword.clear();
        getIt<CacheHelper>().removeData(key: ApiKey.Authorization);
        MethodsHelper().clearCachedProfileImage();
        final updateCubit = context.read<UpdatePatientProfileCubit>();
        updateCubit.profilePic = null;
        updateCubit.existingProfileImageUrl = null;
        context.read<PatientProfileCubit>().emit(PatientProfileInitial());
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      },
      child: Container(
          height: 180,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  alignment: Alignment.center,
                  width: 330,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      )
                    ],
                  ),
                )),
          )),
    );
  }
}
