class DictData {
  final int? id;
  final String? main;
  final String? pronunciation;
  // ignore: non_constant_identifier_names
  final String? part_of_speech;
  final String? definition;
  final String? example;

  // ignore: non_constant_identifier_names
  DictData(
      {this.id,
      this.definition,
      this.example,
      this.main,
      this.part_of_speech,
      this.pronunciation});

  factory DictData.fromJson(Map<String, dynamic> json) {
    return DictData(
        id: json['id'],
        main: json['main'],
        pronunciation: json['pronunciation'],
        part_of_speech: json['part_of_speech'],
        definition: json['definition'],
        example: json['definition']);
  }
}
