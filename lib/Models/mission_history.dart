class MissionHistory {
  final String? etat;
  final String? beginDate;
  final String? ref;
  final double price;
  

  MissionHistory({
    this.etat,
    this.beginDate,
    this.ref,
    required this.price,
  });

  factory MissionHistory.fromJson(Map<String, dynamic> json) {
    try {
      
    return MissionHistory(
      etat: json['etat'],
      beginDate: json['begindate'],
      ref: json['ref'],
      price: (json['price'] ?? 0).toDouble()
    );
    } catch (e, stackTrace) {
      print('Error in MissionHistory.fromJson:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      throw Exception('Failed to parse mission data: $e');
    }
  }
}