import '../data/models/event_model.dart';

class HelperFunctions {
  HelperFunctions._();
  static List<EventModel> convertMapToEventModel(
      List<Map<String, dynamic>> listOfMaps) {
    if (listOfMaps.isNotEmpty) {
      final List<EventModel> eventsList = [];
      for (var eventMap in listOfMaps) {
        eventsList.add(EventModel.fromMap(eventMap));
      }
      return eventsList;
    } else {
      return [];
    }
  }
}
