import 'package:olinom/widgets/sesssion_item.dart';

class MissionModel {
  final int replacementId;
  final String etat;
  final String ref;
  final int classId;
  final int levelId;
  final String levelName;
  final String establishmentName;
  final String title;
  final String subject;
  final int sessions;
  final int students;
  final String dateRange;
  final String? startDate; // Made startDate nullable
  final String? endDate; // Made startDate nullable
  final String? firstDate;
  final String? description; // Made startDate nullable
  final String? description2; // Made startDate nullable
  final double price;
  final bool isEnableAccept;
  final bool urgent;
  final bool isAvailable;
  final List<String> sessionStartDates;
  final List<String> sessionEndDates;
  final List<dynamic> sessionInstructorAvailables;
  

  MissionModel({
    required this.replacementId,
    required this.etat,
    required this.ref,
    required this.classId,
    required this.levelId,
    required this.levelName,
    required this.establishmentName,
    required this.title,
    required this.subject,
    required this.sessions,
    required this.students,
    required this.dateRange,
    this.startDate, // Made startDate nullable
    this.endDate, // Made startDate nullable
    this.firstDate,
    this.description,
    this.description2,
    required this.price,
    required this.isEnableAccept,
    required this.urgent,
    required this.isAvailable,
    required this.sessionStartDates,
    required this.sessionEndDates,
    required this.sessionInstructorAvailables
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      replacementId: json['replacementid'],
      etat: json['etat'],
      ref: json['ref'],
      classId: json['classid'],
      levelId: json['levelid'],
      levelName: json['levelname'],
      establishmentName: json['establishmentname'],
      title: json['name'],
      subject: json['subject'],
      sessions: json['totalsessions'],
      students: json['totalstudents'],
      endDate: json['replacementenddate'],
      dateRange:
          '${json['replacementbegindate']} - ${json['replacementenddate']}',
      startDate: json['replacementbegindate'], // Made startDate nullable
      firstDate: json['firstsessiondate'], // Made startDate nullable
      price: json['price'].toDouble(),
      isEnableAccept: json['isenableaccept'],
      urgent: json['isUrgent'],
      isAvailable: json['isavailable'],
      sessionStartDates: [], // Initialize as empty lists
      sessionEndDates: [],
      sessionInstructorAvailables: []
    );
  }

  factory MissionModel.fromJsonMission(Map<String, dynamic> json) {
  try {
    print("Parsing MissionModel from JSON...");
    print("JSON keys: ${json.keys.toList()}");
    
    // Safely parse sessionsdates
    List<Map<String, dynamic>> sessionsDates = [];
    List<String> sessionStartDates = [];
    List<String> sessionEndDates = [];
    
    if (json['sessionsdates'] != null) {
      sessionsDates = List<Map<String, dynamic>>.from(json['sessionsdates']);
      print("Found ${sessionsDates.length} session dates");
      
      for (var sessionDate in sessionsDates) {
        print("Processing session date: $sessionDate");
        
        // Safely extract dates
        if (sessionDate['begindatetime'] != null && 
            sessionDate['begindatetime'] != null) {
          sessionStartDates.add(sessionDate['begindatetime']);
        }
        
        if (sessionDate['enddatetime'] != null && 
            sessionDate['enddatetime'] != null) {
          sessionEndDates.add(sessionDate['enddatetime']);
        }
      }
    }

    
    
    return MissionModel(
      replacementId: json['replacementid'] ?? 0,
      etat: json['etat'] ?? '',
      ref: json['ref'] ?? '',
      classId: json['classid'] ?? 0,
      levelId: json['levelid'] ?? 0,
      levelName: json['levelname'] ?? '',
      establishmentName: json['establishmentname'] ?? '',
      title: json['name'] ?? '',
      subject: json['subject'] ?? '',
      sessions: json['totalsessions'] ?? 0,
      students: json['totalstudents'] ?? 0,
      dateRange: '${json['replacementbegindate'] ?? ''} - ${json['replacementenddate'] ?? ''}',
      startDate: json['replacementbegindate'],
      endDate: json['replacementenddate'],
      firstDate: json['firstsessiondate'],
      price: (json['price'] ?? 0).toDouble(),
      isEnableAccept: json['isenableaccept'] ?? false,
      urgent: json['isUrgent'] ?? false,
      isAvailable: json['isavailable'] ?? false,
      sessionStartDates: sessionStartDates,
      sessionEndDates: sessionEndDates,
      description: json['description'],
      description2: json['description2'],
      sessionInstructorAvailables: json['sessionInstructorAvailables']
    );
  } catch (e, stackTrace) {
    print('Error in MissionModel.fromJsonMission:');
    print('Error: $e');
    print('Stack trace: $stackTrace');
    print('JSON data: $json');
    throw Exception('Failed to parse mission data: $e');
  }
}
}
