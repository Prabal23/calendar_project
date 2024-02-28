// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;
  final String subTitle;

  const Event(this.title, this.subTitle);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

addToEventLIst(DateTime dateTime, List<Event> eventList) {
  final _kEventSource =
      Map.fromIterable(List.generate(eventList.length, (index) => index),
          key: (item) => dateTime,
          value: (item) {
            return List.generate(
                eventList.length,
                (index) => Event("${eventList[index].title}",
                    "${eventList[index].subTitle}"));
          });
  kEvents.addAll(_kEventSource);
  // ..addAll({
  //   kToday: [
  //     Event('Today\'s Event 1', "Sub title 1"),
  //     Event('Today\'s Event 2', "Sub title 2"),
  //   ],
  // });
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
