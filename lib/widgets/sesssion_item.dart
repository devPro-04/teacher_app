class SessionItem {
  final int sessionId;
  final String visioCourseId;
  final String beginDate;
  final String endDate;
  final String finalDate;
  final bool isAvailable;
  bool isChecked;

  SessionItem({
    required this.sessionId,
    required this.visioCourseId,
    required this.beginDate,
    required this.endDate,
    required this.finalDate,
    required this.isAvailable,
    required this.isChecked
  });

  factory SessionItem.fromJson(Map<String, dynamic> json) {
    try {
      print("Parsing MissionModel from JSON...");
      print("JSON keys: ${json.keys.toList()}");
      print("JSON: ${json}");
    return SessionItem(
      sessionId: json['sessionid'],
      visioCourseId: json['visio_course_id'].toString(),
      beginDate: json['begindatetime'],
      endDate: json['enddatetime'],
      finalDate: json['finaldate'],
      isAvailable: json['isavailable'],
      isChecked: json['ischecked']
    );
    } catch (e, stackTrace) {
      print('Error in SessionItem.fromJson:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      throw Exception('Failed to parse mission data: $e');
    }
  }
}