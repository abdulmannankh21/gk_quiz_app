import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/Models/question_model.dart';
import 'package:convert/convert.dart';
class DBConnect{
  final url = Uri.parse('https://quizapp-faffe-default-rtdb.firebaseio.com/questions.json');
  Future<void> addQuestion(QuestionModel questionModel)async{
    http.post(url,body: jsonEncode({
      'title' : questionModel.title,
      'options': questionModel.options,
    }));
  }
  Future<List<QuestionModel>> fetchQuestion() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      List<QuestionModel> newQuestions = [];

      data.forEach((key, value) {
        // Check if 'title' and 'options' are not null before using them
        if (value['title'] != null && value['options'] != null) {
          var newQuestion = QuestionModel(
            id: key,
            title: value['title'] as String,
            options: Map.castFrom(value['options']),
          );
          newQuestions.add(newQuestion);
        }
      });
      return newQuestions;
    } else {
      // Handle non-200 status codes (e.g., network error)
      throw Exception('Failed to load questions. Status code: ${response.statusCode}');
    }
  }


}