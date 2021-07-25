class ReplaceDto {
  late String pathFile;
  late String from;
  late String to;

  ReplaceDto(this.pathFile, this.from, this.to);

  ReplaceDto.fromJson(Map<String, dynamic> json) {
    pathFile = json['pathFile'] ?? '';
    from = json['from'] ?? '';
    to = json['to'] ?? '';
  }

  Map<String, dynamic> toJson() {
    var  data = <String, dynamic>{};
    data['pathFile'] = pathFile;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
