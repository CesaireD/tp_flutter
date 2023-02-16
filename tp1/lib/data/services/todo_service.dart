import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../models/Todo.dart';

class TodoService {


  static Future<Todo> create (data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '' ;

    var response = await Dio().post(
        Constant.BASE_URL+'todos',
        data: data,
        options: Options(headers: {"authorization": "Bearer $token"})
    );

/*
    final database = openDatabase(
        join(await getDatabasesPath(), 'todos_database.db'),
        onCreate: (db, version){
          return db.execute("CREATE TABLE User(id TEXT PRIMARY KEY,username TEXT, createdAt date, updateAt date, email TEXT);"
              "CREATE TABLE Todo(id TEXT PRIMARY KEY,title TEXT,descrition text,userId TEXT, createdAt date, updateAt date,beginedAt date,deadlinedAt date,finishedAt date)");
        },
        version: 1
    );
     final db = await database;
     await db.insert(data, )*/


    return Todo.fromJson(response.data) ;
  }

  static Future<List<Todo>> fetch ({queryParameters = null}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '' ;

    var response = await Dio().get(
        Constant.BASE_URL+'todos',
        queryParameters: queryParameters,
        options: Options(headers: {"authorization": "Bearer $token"})
    );

    return (response.data!['data'] as List).map((x) => Todo.fromJson(x))
        .toList();
  }

  static Future<Todo> get (id, {queryParameters = null}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '' ;

    var response = await Dio().get(
        Constant.BASE_URL+'todos/'+id,
        queryParameters: queryParameters,
        options: Options(headers: {"authorization": "Bearer $token"})
    );

    return Todo.fromJson(response.data);
  }

  static Future<Todo> patch (id, data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '' ;

    var response = await Dio().patch(
        Constant.BASE_URL+'todos/'+id,
        data: data,
        options: Options(headers: {"authorization": "Bearer $token"})
    );

    return Todo.fromJson(response.data) ;
  }

  static Future<Todo> delete (id, data) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString(Constant.TOKEN_PREF_KEY) ?? '' ;

    var response = await Dio().delete(
        '${Constant.BASE_URL}todos/'+id,
        options: Options(headers: {"authorization": "Bearer $token"})
    );

    return Todo.fromJson(response.data) ;
  }

}