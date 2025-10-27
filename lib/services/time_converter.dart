class TimeConverter {
  String time({required String? curTime, bool isYear = false}) {
    DateTime time = DateTime.parse(curTime!);

    String year = time.year.toString().padLeft(2, '0');
    // Add "0" on the left if month is from 1 to 9
    String month = time.month.toString().padLeft(2, '0');

    // Add "0" on the left if day is from 1 to 9
    String day = time.day.toString().padLeft(2, '0');

    // Add "0" on the left if hour is from 1 to 9
    String hour = time.hour.toString().padLeft(2, '0');

    // Add "0" on the left if minute is from 1 to 9
    String minute = time.minute.toString().padLeft(2, '0');

    // Add "0" on the left if second is from 1 to 9
    String second = time.second.toString();
    if(isYear==true){
      return "$day $month $year";
    }
    // return the "yyyy-MM-dd HH:mm:ss" format
    return "${hour}h$minute";
  }
}
