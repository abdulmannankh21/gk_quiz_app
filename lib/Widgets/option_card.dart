import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Constants/constants.dart';
class OptionCard extends StatelessWidget {
  final String option;
  final Widget icon;
  final VoidCallback onTap;
  const OptionCard({super.key,required this.option,required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: ListTile(
          tileColor: Colors.white,
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: icon,
            radius: 14,
          ),
          onTap: onTap,
          title: Center(
            child: Text(option,style: GoogleFonts.nunito(
              fontSize: 18,
              color:  Colors.black
            ),textAlign: TextAlign.left,),
          ),
        ),
      ),
    );
  }
}
