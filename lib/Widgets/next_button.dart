import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Constants/constants.dart';
class NextButton extends StatelessWidget {
  const NextButton({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10)
      ),
      width: double.infinity,
      child: Text('Next Question',textAlign: TextAlign.center,style: GoogleFonts.nunito(
        fontSize: 18,

      ),),
    );
  }
}
