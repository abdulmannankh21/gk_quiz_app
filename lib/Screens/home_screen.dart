import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/Constants/constants.dart';
import 'package:quiz_app/Models/db_connect.dart';
import 'package:quiz_app/Widgets/next_button.dart';
import 'package:quiz_app/Widgets/option_card.dart';
import 'package:quiz_app/Widgets/question_widget.dart';
import 'package:quiz_app/Widgets/result_box.dart';

import '../Models/question_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var db = DBConnect();
  late Future _questions;
  Future<List<QuestionModel>> getData() async {
    return db.fetchQuestion();
  }

  @override
  void initState() {
    // TODO: implement initState
    _questions = getData();
    super.initState();
  }

  // List<QuestionModel> _questions = [
  //   QuestionModel(
  //       id: '10',
  //       title: 'What is 2 + 2?',
  //       options: {'5': false, '30': false, '4': true, '10': false}),
  //   QuestionModel(
  //       id: '11',
  //       title: 'What is 10 + 20?',
  //       options: {'50': false, '30': true, '40': false, '10': false}),
  // ];
  int index = 0;
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: questionLength,
                onPressed: startOver,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          alreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Please Select Any Option',
            style: GoogleFonts.nunito(),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20),
        ));
      }
    }
  }

  bool isPressed = false;
  bool alreadySelected = false;
  int score = 0;
  void checkAndUpdate(bool value) {
    if (alreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        alreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      alreadySelected = false;
    });
    Navigator.pop(context);
  }

  String getcorrectData(String value) {
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<QuestionModel>>,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data! as List<QuestionModel>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: Text(
                  'EQuiz',
                  style: GoogleFonts.nunito(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: neutral),
                ),
                centerTitle: true,
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Text(
                      'Score: $score',
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: neutral),
                    ),
                  )
                ],
              ),
              body: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: QuestionWidget(
                          question: snapshot.data![index].title,
                          totalQuestion: snapshot.data!.length,
                          indexAction: index),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Divider(
                        color: neutral,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    for (int i = 0;
                        i < snapshot.data![index].options.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: OptionCard(
                          option: snapshot.data![index].options.keys
                              .toList()[i]
                              .toString(),
                          icon: isPressed
                              ? snapshot.data![index].options.values
                                          .toList()[i] ==
                                      true
                                  ? Container(
                                      color: Colors.transparent,
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      ),
                                    )
                                  : Container(
                                      color: Colors.transparent,
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    )
                              : Container(),
                          onTap: () {
                            setState(() {
                              isPressed = true;
                              if (snapshot.data![index].options.values
                                      .toList()[i] ==
                                  true) {
                                score++;
                              }
                            });
                            snapshot.data![index].options.values.toList()[i];
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: snapshot.data![index].options.values
                                          .toList()[i] ==
                                      true
                                  ? Text("Correct!")
                                  : Text(
                                      'Incorrect! Correct Answer: ${snapshot.data![index].options.entries.where((entry) => entry.value == true).map((entry) => entry.key).join(', ')}',
                                      style: GoogleFonts.nunito(),
                                    ),
                              backgroundColor: snapshot
                                          .data![index].options.values
                                          .toList()[i] ==
                                      true
                                  ? Colors.green
                                  : Colors.red,
                              behavior: SnackBarBehavior
                                  .floating, // Set the duration for which the SnackBar will be displayed
                            ));
                          },
                        ),
                      ),
                  ],
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => Future.delayed(Duration(seconds: 2), () {
                  nextQuestion(snapshot.data!.length);
                }),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: neutral,
          ));
        }
        return Center(child: Text('No data'));
      },
    );
  }
}
