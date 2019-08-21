class Course {
  int id;
  String title;
  List<Section> sections;

  Course({
    this.id,
    this.title,
    this.sections,
  });

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        sections: List<Section>.from(
          json["sections"].map((x) => Section.fromMap(x)),
        ),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "sections": List<dynamic>.from(sections.map((x) => x.toMap())),
      };
}

class Section {
  String title;
  String subtitle;
  String category;
  int total;
  int step;

  Section({
    this.title,
    this.subtitle,
    this.category,
    this.total,
    this.step,
  });

  factory Section.fromMap(Map<String, dynamic> json) => Section(
        title: json["title"],
        subtitle: json["subtitle"],
        category: json["category"],
        total: json["total"],
        step: json["step"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "subtitle": subtitle,
        "category": category,
        "total": total,
        "step": step,
      };
}
