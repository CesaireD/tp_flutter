
import 'package:dio/dio.dart';

import '../../utils/constants.dart';
import '../models/AuthenticatedUser.dart';

class UserService {

  static Future<AuthenticatedUser> authentication (data) async {
    var result = await Dio().post(Constant.BASE_URL+'authentication', data: data);
    return AuthenticatedUser.fromJson(result.data);
  }

  static Future<User> create (data) async {
    var response = await Dio().post(Constant.BASE_URL+'users', data: data);
    return User.fromJson(response.data) ;
  }

  static Future<User> createTodo (data) async {
    var response = await Dio().post(Constant.BASE_URL+'todos', data: data);
    return User.fromJson(response.data) ;
  }

}