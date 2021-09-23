class NewFileDto {
  String pathFile;
  String pathTemplete;
  String extension;
  bool replaceOldFileWithNew;
  bool generate;

  NewFileDto({
    this.pathFile = '',
    this.pathTemplete = '',
    this.extension = 'dart',
    this.replaceOldFileWithNew = false,
    this.generate = false,
  });

  NewFileDto.fromJson(Map<String, dynamic> json):
    pathFile = json['pathFile'] ?? '',
    pathTemplete = json['pathTemplete'] ?? '',
    extension = json['extension'] ?? 'dart',
    generate = json['generate'] ?? false,
    replaceOldFileWithNew = json['replaceOldFileWithNew'] ?? false;
  
  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['pathFile'] = pathFile;
    data['pathTemplete'] = pathTemplete;
    data['extension'] = extension;
    data['replaceOldFileWithNew'] = replaceOldFileWithNew;

    data['generate'] = generate;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'pathFile': pathFile,
      'pathTemplete': pathTemplete,
      'extension': extension,
      'replaceOldFileWithNew': replaceOldFileWithNew,
      'generate': generate,
    };
  }
}
