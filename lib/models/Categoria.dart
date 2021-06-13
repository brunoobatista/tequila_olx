import 'dart:convert';

class Categoria {
  final String label;
  final String value;
  Categoria({
    required this.label,
    required this.value,
  });

  Categoria copyWith({
    String? label,
    String? value,
  }) {
    return Categoria(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'value': value,
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      label: map['label'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Categoria.fromJson(String source) =>
      Categoria.fromMap(json.decode(source));

  @override
  String toString() => 'Categoria(label: $label, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Categoria && other.label == label && other.value == value;
  }

  @override
  int get hashCode => label.hashCode ^ value.hashCode;
}
