import 'package:get_it/get_it.dart';
import 'package:skintelligent/commons.dart';
final getIt = GetIt.instance;
void setputServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper()); 
}

