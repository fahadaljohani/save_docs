// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DocumentModel {
  final int? id;
  final String to;
  final String from;
  final String description;
  final int attachNumber;
  final DateTime createdAt;
  DocumentModel({
    this.id,
    required this.to,
    required this.from,
    required this.description,
    required this.attachNumber,
    required this.createdAt,
  });

  DocumentModel copyWith({
    int? id,
    String? to,
    String? from,
    String? description,
    int? attachNumber,
    DateTime? createdAt,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      to: to ?? this.to,
      from: from ?? this.from,
      description: description ?? this.description,
      attachNumber: attachNumber ?? this.attachNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'to': to,
      'from': from,
      'description': description,
      'attachNumber': attachNumber,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      id: map['id'] != null ? map['id'] as int : null,
      to: map['to'] as String,
      from: map['from'] as String,
      description: map['description'] as String,
      attachNumber: map['attachNumber'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentModel.fromJson(String source) => DocumentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocumentModel(id: $id, to: $to, from: $from, description: $description, attachNumber: $attachNumber, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant DocumentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.to == to &&
        other.from == from &&
        other.description == description &&
        other.attachNumber == attachNumber &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        to.hashCode ^
        from.hashCode ^
        description.hashCode ^
        attachNumber.hashCode ^
        createdAt.hashCode;
  }
}
