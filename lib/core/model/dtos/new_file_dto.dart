class NewFileDto {
  late String pathFile;
  late String pathTemplete;
  late String extension;

  late bool generate;

  NewFileDto(
    this.pathFile,
    this.pathTemplete,
    this.extension, {
    this.generate = false,
  });

  NewFileDto.fromJson(Map<String, dynamic> json) {
    pathFile = json['pathFile'] ?? '';
    pathTemplete = json['pathTemplete'] ?? '';
    extension = json['extension'] ?? 'dart';

    generate = json['generate'] ?? false;
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['pathFile'] = pathFile;
    data['pathTemplete'] = pathTemplete;
    data['extension'] = extension;

    data['generate'] = generate;
    return data;
  }
}
