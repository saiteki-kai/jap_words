import 'dart:convert';
import 'package:http/http.dart';
import 'package:nihongo_courses/models/course.dart';
import 'package:nihongo_courses/models/word.dart';

class ApiHelper {
  static final ApiHelper _instance = ApiHelper._internal();

  factory ApiHelper() => _instance;

  ApiHelper._internal();

  static get instance => _instance;

  final baseURL = "https://jap-words-api.herokuapp.com";

  Future<List<Course>> getCourses() async {
    var response = await get(baseURL + "/courses");
    Iterable list = json.decode(response.body);
    return list.map((x) => Course.fromMap(x)).toList();
  }

  Future<List<WordItem>> getWords({
    int limit,
    int offset,
    String partOfSpeech,
    String category,
  }) async {
    var url = baseURL + "/words/";

    if (limit != null) url += "$limit/";
    if (offset != null) url += "$offset/";
    if (partOfSpeech != null) url += "?pos=${partOfSpeech.toLowerCase()}";
    if (category != null) {
      url += (partOfSpeech == null ? "?" : "&");
      url += "cat=${category.toLowerCase()}";
    }
    print(url);

    var response = await get(url);
    Iterable list = json.decode(response.body);
    return list.map((x) => WordItem.fromMap(x)).toList();
  }
}
