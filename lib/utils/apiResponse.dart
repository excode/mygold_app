abstract class BaseModel {
  Map<String, dynamic> toJson();
  // Map<String, dynamic> fromJson();
}

class ApiResponse<T extends BaseModel> {
  List<T> docs;
  int count;
  int perpage;
  int page;

  ApiResponse({
    required this.docs,
    required this.count,
    required this.perpage,
    required this.page,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    var docsJson = json['docs'] as List;
    List<T> docsList = docsJson.map((doc) => fromJsonT(doc)).toList();

    return ApiResponse<T>(
      docs: docsList,
      count: json['count'],
      perpage: json['perpage'],
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docs': docs.map((doc) => doc.toJson()).toList(),
      'count': count,
      'perpage': perpage,
      'page': page,
    };
  }
}
