class NotiHelper {
  String body;
  String missionId;
  String missionType;
  String textInsideATag;

  NotiHelper({
    required this.body,
    required this.missionId,
    required this.missionType,
    required this.textInsideATag,
  });

  factory NotiHelper.fromDescription(String description) {
    // Regular expression to extract text before <a> tag
    RegExp bodyRegExp = RegExp(r'^(.*)<a');
    String body = bodyRegExp.firstMatch(description)?.group(1)?.trim() ?? '';

    // Regular expression to extract mission id and type
    RegExp missionIdAndTypeRegExp = RegExp(r'/detail/(\d+)/(\w+)');
    RegExpMatch? match = missionIdAndTypeRegExp.firstMatch(description);
    String missionId = match?.group(1) ?? '';
    String missionType = match?.group(2) ?? '';

    // Regular expression to extract the text inside the <a> tag
    RegExp textInsideATagRegExp = RegExp(r'<a [^>]*>([^<]*)</a>');
    String textInsideATag =
        textInsideATagRegExp.firstMatch(description)?.group(1)?.trim() ?? '';

    return NotiHelper(
      body: body,
      missionId: missionId,
      missionType: missionType,
      textInsideATag: textInsideATag,
    );
  }
}
