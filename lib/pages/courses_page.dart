import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:nihongo_courses/models/course.dart';
import 'package:nihongo_courses/utils/api_helper.dart';
import 'package:nihongo_courses/widgets/step_item.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _onTap(Course c, Section s) {
      Navigator.of(context).pushNamed(
        "/course",
        arguments: {"section": s, "course_title": c.title},
      );
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.indigoAccent,
      child: FutureBuilder(
        future: ApiHelper.instance.getCourses(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return EasyRefresh(
              header: BezierCircleHeader(
                backgroundColor: Colors.indigo,
                color: Colors.white,
              ),
              onRefresh: () async => await ApiHelper.instance
                  .getCourses(), // TODO: rebuild onRefresh!!!!
              child: ListView.builder(
                itemCount: snapshot.data != null ? snapshot.data.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  var course = snapshot.data[index] as Course;

                  var steps = course.sections.map((s) {
                    return buildCard(
                      s.title,
                      s.subtitle,
                      () => _onTap(course, s),
                    );
                  }).toList();

                  return buildSection(course.title, steps);
                },
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Container buildSection(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 20),
          ...children
        ],
      ),
    );
  }

  Widget buildCard(String title, String subitle, Function _onTap) {
    return GestureDetector(
      child: StepItem(title: title, subtitle: subitle, active: false),
      onTap: _onTap,
    );
  }
}
