import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:nihongo_courses/models/course.dart';
import 'package:nihongo_courses/utils/utils.dart';
import 'package:nihongo_courses/widgets/step_item.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  Section _section;
  String _courseTitle;

  // TODO: classe Cell(number associated, active)
  var cells = Map<int, bool>();
  int gridSize = 100;

  _generateCells() {
    // TODO: calcola offset e poi crea celle

    cells = Map<int, bool>();
    var stepsCount = (_section.total / _section.step).ceil();
    for (var i = 0; i < gridSize; i++) {
      // ... algorithm for neighbours
      if (Random().nextDouble() < 0.2 && stepsCount > 0) {
        cells[i] = true;
        stepsCount--;
      } else {
        cells[i] = false;
      }
    }
  }

  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    _section = args["section"];
    _courseTitle = args["course_title"];

    _generateCells();

    void _onTap(int index) {
      Map args = {
        "offset": _section.step * index,
        "limit": _section.step,
        "title": "$_courseTitle - Step ${index + 1}",
        "section_title": _section.subtitle,
        "section_category": _section.category,
        "course_title": _courseTitle
      };

      if (_courseTitle == "Parts of Speech")
        args["partOfSpeech"] = _section.subtitle;

      Navigator.of(context).pushNamed("/step", arguments: args);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_section.subtitle),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white24,
            child: Column(
              children: <Widget>[
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  value: 0.3,
                ),
                Expanded(
                  child: buildListView(_onTap),
                ),
              ],
            ),
          ),
          Container(
            child: buildProgresses(),
            padding: EdgeInsets.only(left: 8.0, top: 16.0),
            alignment: Alignment.topLeft,
          ),
        ],
      ),
    );
  }

  Widget buildListView(void _onTap(int n)) {
    int i = 0;
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          _scale = details.scale;
        });
      },
      child: Transform(
        transform: Matrix4.skew(10.1, -0.5)..scale(_scale),
        alignment: Alignment.center,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          reverse: true,
          itemCount: cells.length,
          itemBuilder: (BuildContext context, int index) {
            final count = 10;
            final text = Utils.getJapaneseNumber(count - i);

            if (cells[index]) {
              i++;
              return GestureDetector(
                child: StepItem(
                  title: text,
                  subtitle: "Step ${index + 1}",
                  active: cells[index],
                ),
                onTap: () => _onTap(index),
              );
            } else {
              return StepItem(title: "", subtitle: "", active: false);
            }
          },
        ),
      ),
    );
  }

  Widget buildProgresses() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        buildProgress("Learning", Colors.yellow, 35),
        buildProgress("Familiar", Colors.green, 23),
        buildProgress("Mastered", Colors.lightBlue, 12),
        buildProgress("Burned", Colors.red, 2),
      ],
    );
  }

  Widget buildProgress(String title, MaterialColor color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 50,
          width: 50,
          child: LiquidCircularProgressIndicator(
            value: progress / 100, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(color[400]),
            backgroundColor: Colors.white,
            borderColor: color[600],
            borderWidth: 5.0,
            direction: Axis.vertical,
            center: Text(
              "${progress.round()}%",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            //color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
