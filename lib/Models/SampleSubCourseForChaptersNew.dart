class ChaptersResponse {
  List<String> chapters;

    ChaptersResponse({required this.chapters});

    factory ChaptersResponse.fromJson(Map<String, dynamic> json) {

    return ChaptersResponse(

      chapters: List<String>.from(json['chapters'].map((chapter) => chapter.toString())),

    );
  }
}
