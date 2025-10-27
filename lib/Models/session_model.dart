class SessionModel {
  final int? id;
  final int? sessionid;
  final String? ref;
  final String? levelname;
  final String? establishmentName;
  final String? title;
  final String? subject;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? starTime;
  final String? endTime;
  final String? session;
  final String? time;
  final bool? current;
  final String? note;
  final int? student;
  final int? sessionnumber;
  final int? totalsession;
  final String? reportnextsession;
  final String? report;

  SessionModel({
    this.id,
    this.sessionid,
    this.ref,
    this.levelname,
    this.establishmentName,
    this.note = 'uyghv',
    this.time,
    this.title,
    this.subject,
    this.description,
    this.startDate,
    this.endDate,
    this.starTime,
    this.endTime,
    this.session,
    this.current = false,
    this.student,
    this.sessionnumber,
    this.totalsession,
    this.reportnextsession,
    this.report
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['replacementid'],
      sessionid: json['sessionid'],
      ref: json['ref'],
      levelname: json['levelname'],
      establishmentName: json['establishmentname'],
      title: json['name'],
      subject: json['subject'],
      description: json['description'],
      startDate: json['sessionbegindatetime'],
      starTime: json['sessionbegindatetime'],
      endTime: json['sessionenddatetime'],
      endDate: json['sessionenddatetime'],
      session: json['session'],
      time: json['time'],
      current: json['issessioncancelled'] == null ? false : true,
      note: json['note'],
      student: json['totalstudents'],
      sessionnumber: json['sessionnumber'],
      totalsession: json['totalsessions'],
    );
  }

  factory SessionModel.fromJsonSession(Map<String, dynamic> json) {
    return SessionModel(
      id: json['replacementid'],
      sessionid: json['sessionid'],
      ref: json['ref'],
      levelname: json['levelname'],
      establishmentName: json['establishmentname'],
      title: json['name'],
      subject: json['subject'],
      description: json['description'],
      startDate: json['sessionbegindatetime'],
      starTime: json['sessionbegindatetime'],
      endTime: json['sessionenddatetime'],
      endDate: json['sessionenddatetime'],
      session: json['session'],
      time: json['time'],
      current: json['issessioncancelled'] == null ? false : true,
      note: json['note'],
      student: json['totalstudents'],
      sessionnumber: json['sessionnumber'],
      totalsession: json['totalsessions'],
      report: json['report'],
      reportnextsession: json['reportnextsession']
    );
  }
}
