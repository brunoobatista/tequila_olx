abstract class Model {
  get id;
  set id(value);
  Map<String, dynamic> toMap();

  String toJson();
}
