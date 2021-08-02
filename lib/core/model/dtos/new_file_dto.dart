class NewFileDto {
  late String pathFile;
  late String pathTemplete;

  late bool generate;

  NewFileDto(
    this.pathFile,
    this.pathTemplete, {
    this.generate = false,
  });

  NewFileDto.fromJson(Map<String, dynamic> json) {
    pathFile = json['pathFile'] ?? '';
    pathTemplete = json['pathTemplete'] ?? '';

    generate = json['generate'] ?? false;
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['pathFile'] = pathFile;
    data['pathTemplete'] = pathTemplete;

    data['generate'] = generate;
    return data;
  }
}
