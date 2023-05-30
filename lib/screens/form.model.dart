class FormModel {
  FormModel({
    required this.title,
    required this.fields,
  });
  late final String title;
  late final List<Fields> fields;

  FormModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    fields = List.from(json['fields']).map((e) => Fields.fromJson(e)).toList();
  }
}

class Fields {
  Fields({
    required this.label,
    required this.fieldType,
    this.options,
  });
  late final String label;
  late final String fieldType;
  List<Options>? options;

  Fields.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    fieldType = json['fieldType'];
    options = json['options'] == null
        ? []
        : List.from(json['options']).map((e) => Options.fromJson(e)).toList();
  }
}

class Options {
  Options({
    this.color,
    this.isFaulty,
    this.optionLabel,
    this.optionValue,
  });
  String? color;
  bool? isFaulty;
  String? optionLabel;
  String? optionValue;

  Options.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    isFaulty = json['is_faulty'];
    optionLabel = json['optionLabel'];
    optionValue = json['optionValue'];
  }
}
