//
//
// import 'package:get_storage/get_storage.dart';
//
// import '../../model/auth/login_model.dart';
// import '../database/local/cache_helper.dart';
//
// LoginData? getUser() {
//   if (CacheHelper.get(key: 'token')==null) {
//     return null;
//   }
//   return UserModelFromJson(GetStorage().read<String>("user")!);
// }
//
// void setUser(LoginData user) {
//   GetStorage().write("user", UserModelToJson(user));
//   // GetStorage().writeInMemory("user", user);
// }
// setToken(String? token) {
//   CacheHelper.put(key: 'token',value: token);
// }
//
// //
//  getToken() {
//
//   CacheHelper.get(key: 'token');
//
// }
//
// removeUser() {
//   GetStorage().remove('user');
// }