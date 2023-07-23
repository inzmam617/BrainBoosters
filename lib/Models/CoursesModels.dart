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
      chapters: List<Chapter>.from(json['chapters'].map((chapterJson) => Chapter.fromJson(chapterJson))),
    );
  }
}
class Chapter {
  String id;
  String name;
  Chapter({required this.id, required this.name});
  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['_id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
  // Method to convert Chapter to SubCourse
  SubCourse toSubCourse() {
    return SubCourse(
      id: this.id,
      name: this.name,
      chapters: [this], // Add the current Chapter as a single item in the SubCourse's chapters list
    );
  }

}
