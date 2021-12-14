import 'dart:convert';

class Note {
  String? id;
  String? title;
  String? content;
  int? color;
  String? createdAt;
  String? updatedAt;

  Note({
    this.id,
    this.content,
    this.title,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    title = json['title'];
    color = json['color'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['content'] = this.content;
    data['title'] = this.title;
    data['color'] = this.color;

    return data;
  }

  dynamic stringToJson(String content) {
    return jsonDecode(content);
  }

  String jsonToString(dynamic jsonContent) {
    return jsonEncode(jsonContent);
  }
}
