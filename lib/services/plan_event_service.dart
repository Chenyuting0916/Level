import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:level/models/event.dart';
import 'package:level/services/auth_service.dart';

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
      await updateEvent({
        "events": [
          Event(eventName: eventName, eventDate: eventDate, userId: userId)
              .toMap()
        ]
      });
    } else {
      events.add(
          Event(eventName: eventName, eventDate: eventDate, userId: userId));
      await updateEvent({"events": events.map<Map>((e) => e.toMap())});
    }
  }

  Future updateEvent(Map<String, dynamic> updateData) async {
    final snapshot = _firestore.collection('events').doc(userId);

    snapshot.set(updateData);
  }
}
