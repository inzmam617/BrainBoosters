
class FriendRequest {
  final String id;
  final String name;
  final String password;

  FriendRequest({
    required this.id,
    required this.name,
    required this.password,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: json['_id'],
      name: json['name'],
      password: json['password'],
    );
  }
}

class FriendRequestResponse {
  final List<FriendRequest> friendRequests;

  FriendRequestResponse({
    required this.friendRequests,
  });

  factory FriendRequestResponse.fromJson(Map<String, dynamic> json) {
    var list = json['friendRequests'] as List<dynamic>;
    List<FriendRequest> requests =
    list.map((item) => FriendRequest.fromJson(item)).toList();

    return FriendRequestResponse(friendRequests: requests);
  }
}
