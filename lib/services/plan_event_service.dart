import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:level/models/event.dart';
import 'package:level/services/auth_service.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanEventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = AuthService().currentUser!.uid;

  Future<List<Event>?> getEvents() async {
    var doc = await _firestore.collection('events').doc(userId).get();

    if (doc.exists) {
      List<Event> events = [];
      var eventsFromJson = doc.data()!['events'];
      if (eventsFromJson is List) {
        events = eventsFromJson.map((e) => Event.fromJson(e)).toList();
      }

      return events;
    }
    return null;
  }

  addEvent(String eventName, DateTime eventDate) async {
    var events = await getEvents();
    if (events == null) {
      await createEvent({
        "events": [
          Event(
                  eventName: eventName,
                  eventDate: eventDate,
                  userId: userId,
                  isCompleted: false)
              .toMap()
        ]
      });
    } else {
      events.add(Event(
          eventName: eventName,
          eventDate: eventDate,
          userId: userId,
          isCompleted: false));
      await updateEvent({"events": events.map<Map>((e) => e.toMap())});
    }
  }

  Future createEvent(Map<String, dynamic> updateData) async {
    final snapshot = _firestore.collection('events').doc(userId);

    snapshot.set(updateData);
  }

  Future updateEvent(Map<String, dynamic> updateData) async {
    final snapshot = _firestore.collection('events').doc(userId);

    snapshot.update(updateData);
  }

  editEvent(DateTime date, int index, String text) async {
    var events = await getEvents();
    events!
        .where((element) => isSameDay(element.eventDate, date))
        .toList()[index]
        .eventName = text;

    await updateEvent({"events": events.map<Map>((e) => e.toMap())});
  }

  deleteEvent(DateTime date, int index) async {
    var events = await getEvents();
    var needRemove = events!
        .where((element) => isSameDay(element.eventDate, date))
        .toList()[index];

    events.remove(needRemove);
    await updateEvent({"events": events.map<Map>((e) => e.toMap())});
  }

  completeEvent(DateTime date, int index, bool value) async {
    var events = await getEvents();
    events!
        .where((element) => isSameDay(element.eventDate, date))
        .toList()[index]
        .isCompleted = value;

    await updateEvent({"events": events.map<Map>((e) => e.toMap())});
  }
}
