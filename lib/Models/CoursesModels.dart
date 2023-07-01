class Course {
  String id;
  String name;
  List<SubCourse> subCourses;

  Course({required this.id, required this.name, required this.subCourses});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      name: json['name'],
      subCourses: List<SubCourse>.from(json['subcourses'].map((subJson) => SubCourse.fromJson(subJson))),
    );
  }
}

class SubCourse {
  String id;
  String name;
  List<Chapter> chapters;

  SubCourse({required this.id, required this.name, required this.chapters});

  factory SubCourse.fromJson(Map<String, dynamic> json) {
    return SubCourse(
      id: json['_id'],
      name: json['name'],
      chapters: json['chapters'] != null
          ? List<Chapter>.from(json['chapters'].map((chapterJson) => Chapter.fromJson(chapterJson)))
          : [],
    );
  }
}

class Chapter {
  String id;
  String name;
  String content;

  Chapter({required this.id, required this.name, required this.content});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['_id'],
      name: json['name'],
      content: json['content'],
    );
  }
}