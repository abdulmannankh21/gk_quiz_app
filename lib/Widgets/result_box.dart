import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Constants/constants.dart';

class ResultBox extends StatelessWidget {
  final int result;
  final int questionLength;
  final VoidCallback onPressed;
  const ResultBox(
      {super.key, required this.result, required this.questionLength,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: EdgeInsets.all(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Result',
              style: GoogleFonts.nunito(color: neutral, fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              child: Text(
                '$result/$questionLength',
                style: GoogleFonts.nunito(fontSize: 30),
              ),
              radius: 70,
              backgroundColor: result == questionLength/2
                  ? Colors.yellow
                  : result < questionLength / 2
                      ? incorrect
                      : correct
            ),
            SizedBox(height: 20,),
            Text(result == questionLength/2
                ? 'Almost There'
                : result < questionLength / 2
                ? 'Try Again?'
                : 'Great'!,style: GoogleFonts.nunito(color: neutral,),),
            SizedBox(height: 25,),
            GestureDetector(
              onTap: onPressed,
              child: Text('Start Over',style: GoogleFonts.nunito(
                color: Colors.blue,
                fontSize: 20,
                letterSpacing: 1
              ),),
            )

          ],
        ),
      ),
    );
  }
}
