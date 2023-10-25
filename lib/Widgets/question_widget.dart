import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Constants/constants.dart';
class QuestionWidget extends StatelessWidget {
  final String question;
  final int indexAction;
  final int totalQuestion;
  const QuestionWidget({super.key,required this.question,required this.totalQuestion,required this.indexAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Question ${indexAction + 1}/$totalQuestion: $question',style: GoogleFonts.nunito(
        fontSize: 24,
        fontWeight: FontWeight.w300,
        color: neutral
      ),),
    );
  }
}
