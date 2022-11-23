import 'package:flutter/material.dart';
import 'package:mcgapp/main.dart';
import 'package:mcgapp/widgets/bottom_sheet.dart';

import '../classes/course.dart';
import '../classes/room.dart';

double height = 60;
double padding = 1;

class Timetable extends StatelessWidget {
  const Timetable({Key? key, required this.week}) : super(key: key);

  final String week;

  static final Color rowColor = themeManager.themeMode == ThemeMode.dark ? Colors.grey.shade800 : Colors.grey.shade400;

  Widget _dayHeader(String day) {
    return Expanded(
      child: Container(
        height: 32,
        color: rowColor,
        child: Center(child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold))),
      ),
    );
  }

  Widget _lessonHeader(String lesson) {
    return Container(
      height: height + padding * 2,
      width: 28,
      color: rowColor,
      child: Center(
        child: Text(lesson, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Course? _getCourse(String time) {
    for (Course course in userCourses) {
      for (List<String> t in course.times) {
        if (t[0] == time) return course;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Container(height: 32, width: 28, color: rowColor),
            _dayHeader('Mo'),
            _dayHeader('Di'),
            _dayHeader('Mi'),
            _dayHeader('Do'),
            _dayHeader('Fr'),
          ],
        ),
        Row(
          children: [
            _lessonHeader('1'),
            TimetableEntry(course: _getCourse('${week}Mo1'), week: week, weekday: 'Montag', lesson: 1),
            TimetableEntry(course: _getCourse('${week}Di1'), week: week, weekday: 'Dienstag', lesson: 1),
            TimetableEntry(course: _getCourse('${week}Mi1'), week: week, weekday: 'Mittwoch', lesson: 1),
            TimetableEntry(course: _getCourse('${week}Do1'), week: week, weekday: 'Donnerstag', lesson: 1),
            TimetableEntry(course: _getCourse('${week}Fr1'), week: week, weekday: 'Freitag', lesson: 1),
          ],
        ),
        Row(
          children: [
            _lessonHeader('2'),
            TimetableEntry(course: _getCourse('${week}Mo2'), week: week, weekday: 'Montag', lesson: 2),
            TimetableEntry(course: _getCourse('${week}Di2'), week: week, weekday: 'Dienstag', lesson: 2),
            TimetableEntry(course: _getCourse('${week}Mi2'), week: week, weekday: 'Mittwoch', lesson: 2),
            TimetableEntry(course: _getCourse('${week}Do2'), week: week, weekday: 'Donnerstag', lesson: 2),
            TimetableEntry(course: _getCourse('${week}Fr2'), week: week, weekday: 'Freitag', lesson: 2),
          ],
        ),
        Row(
          children: [
            _lessonHeader('3'),
            TimetableEntry(course: _getCourse('${week}Mo3'), week: week, weekday: 'Montag', lesson: 3),
            TimetableEntry(course: _getCourse('${week}Di3'), week: week, weekday: 'Dienstag', lesson: 3),
            TimetableEntry(course: _getCourse('${week}Mi3'), week: week, weekday: 'Mittwoch', lesson: 3),
            TimetableEntry(course: _getCourse('${week}Do3'), week: week, weekday: 'Donnerstag', lesson: 3),
            TimetableEntry(course: _getCourse('${week}Fr3'), week: week, weekday: 'Freitag', lesson: 3),
          ],
        ),
        Row(
          children: [
            _lessonHeader('4'),
            TimetableEntry(course: _getCourse('${week}Mo4'), week: week, weekday: 'Montag', lesson: 4),
            TimetableEntry(course: _getCourse('${week}Di4'), week: week, weekday: 'Dienstag', lesson: 4),
            TimetableEntry(course: _getCourse('${week}Mi4'), week: week, weekday: 'Mittwoch', lesson: 4),
            TimetableEntry(course: _getCourse('${week}Do4'), week: week, weekday: 'Donnerstag', lesson: 4),
            TimetableEntry(course: _getCourse('${week}Fr4'), week: week, weekday: 'Freitag', lesson: 4),
          ],
        ),
      ],
    );
  }
}

String _getTimesFromLesson(int lesson) {
  switch (lesson) {
    case 1:
      return '8:00 - 9:30';
    case 2:
      return '9:50 - 11:20';
    case 3:
      return '11:30 - 13:00';
    case 4:
      return '13:40 - 15:10';
    case 5:
      return '15:15 - 16:45';
    default:
      return '0:00 - 0:00';
  }
}

class TimetableEntry extends StatelessWidget {
  const TimetableEntry({
    Key? key,
    required this.course,
    required this.week,
    required this.weekday,
    required this.lesson,
  }) : super(key: key);

  final Course? course;
  final String week;
  final String weekday;
  final int lesson;

  Room? get _room {
    String time = '$week${weekday.substring(0, 2)}$lesson';

    for (List<String> t in course!.times) {
      if (t[0] == time) return Room.fromNumber(t[1]);
    }
    return null;
  }

  List<Widget> get _details {
    return [
      ListTile(
        title: Text('${course!.subject.name} (${course!.title})'),
        leading: Icon(Icons.school, color: course!.subject.backgroundColor),
      ),
      ListTile(
        title: Text(_getTimesFromLesson(lesson)),
        leading: const Icon(Icons.access_time_outlined),
      ),
      ListTile(
        title: Text('${course!.teacher.anrede} ${course!.teacher.nachname}'),
        leading: const Icon(Icons.person),
      ),
      ListTile(
        title: Text(_room?.number ?? ''),
        leading: const Icon(Icons.place),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: course == null
          ? Container(height: height, width: double.infinity, color: Theme.of(context).canvasColor)
          : GestureDetector(
              onTap: () {
                showMCGBottomSheet(
                  context,
                  '$weekday, $lesson. Block ($week)',
                  _details,
                  [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {},
                    ),
                  ],
                );
              },
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)), color: course!.subject.backgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          course!.subject.short,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: course!.subject.foregroundColor,
                          ),
                        ),
                        Text(
                          _room?.number == '0.Sporthalle' ? 'TH' : _room?.number ?? '',
                          style: TextStyle(color: course!.subject.foregroundColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
