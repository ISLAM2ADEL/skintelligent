part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}
final class SignupcubitImagePicked  extends SignupState {
  final File image;
  SignupcubitImagePicked(this.image);
}
