class Note {
  List<Content> content;
  String id;
  String title;
  String createdAt;
  String updatedAt;

  Note({
    this.content,
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  Note.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content.add(Content.fromJson(v));
      });
    }
    id = json['_id'];
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    return data;
  }
}

class Content {
  String insert;
  Attributes attributes;

  Content({this.insert, this.attributes});

  Content.fromJson(Map<String, dynamic> json) {
    insert = json['insert'];
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['insert'] = this.insert;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    return data;
  }
}

class Attributes {
  int header;
  int indent;
  bool strike;
  bool italic;
  bool bold;
  bool underline;
  bool blockquote;
  bool codeBlock;
  String background;
  String color;
  String width;
  String style;
  String link;
  String list;
  String align;
  String font;
  String size;
  String token;

  Attributes({
    this.header,
    this.indent,
    this.strike,
    this.italic,
    this.bold,
    this.underline,
    this.blockquote,
    this.codeBlock,
    this.background,
    this.color,
    this.width,
    this.style,
    this.link,
    this.list,
    this.align,
    this.font,
    this.size,
    this.token,
  });

  Attributes.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    indent = json['indent'];
    strike = json['strike'];
    italic = json['italic'];
    bold = json['bold'];
    underline = json['underline'];
    blockquote = json['blockquote'];
    codeBlock = json['code-block'];
    background = json['background'];
    color = json['color'];
    width = json['width'];
    style = json['style'];
    link = json['link'];
    list = json['list'];
    align = json['align'];
    font = json['font'];
    size = json['size'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['header'] = this.header;
    data['indent'] = this.indent;
    data['strike'] = this.strike;
    data['italic'] = this.italic;
    data['bold'] = this.bold;
    data['underline'] = this.underline;
    data['blockquote'] = this.blockquote;
    data['code-block'] = this.codeBlock;
    data['background'] = this.background;
    data['color'] = this.color;
    data['width'] = this.width;
    data['style'] = this.style;
    data['link'] = this.link;
    data['list'] = this.list;
    data['align'] = this.align;
    data['font'] = this.font;
    data['size'] = this.size;
    data['token'] = this.token;
    return data;
  }
}
