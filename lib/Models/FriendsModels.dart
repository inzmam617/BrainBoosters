class Student {
  final String id;
  final String name;
  final String email;
  final List<String> friends;
  final List<String> friendRequests;
  final String token;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.friends,
    required this.friendRequests,
    required this.token,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      friends: List<String>.from(json['friends'] ?? []),
      friendRequests: List<String>.from(json['friendRequests'] ?? []),
      token: json['token'] ?? '',
    );
  }
}

class StudentList {
  final List<Student> students;

  StudentList({
    required this.students,
  });

  factory StudentList.fromJson(Map<String, dynamic> json) {
    return StudentList(
      students: List<Student>.from((json['students'] as List<dynamic>).map((studentJson) => Student.fromJson(studentJson))),
    );
  }
}
