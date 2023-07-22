class User {
  final String id;
  final String name;
  final String email;
  final List<String>? friends;
  final List<String>? friendRequests;

  User({
    required this.id,
    required this.name,
    this.friends,
    this.friendRequests,
    required this.email,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    if(json.containsKey('friends')){
      return User(
        id: json['_id']!=null?json['_id']:"",
        name: json['name']!=null?json['name']:"",
        email: json['email']!=null?json['email']:"",
        friends: json['friends']!=[]?List<String>.from(json['friends']):[],

      );
    }
    return User(
      id: json['_id']!=null?json['_id']:"",
      name: json['name']!=null?json['name']:"",
      email: json['email']!=null?json['email']:"",
      friendRequests: json['friendRequests']!=[]?List<String>.from(json['friendRequests']):[],

    );
  }
}

class FriendsListsModel {
  final List<User> friends;
  final List<User> nonFriends;

  FriendsListsModel({
    required this.friends,
    required this.nonFriends,
  });

  factory FriendsListsModel.fromJson(Map<String, dynamic> json) {
    return FriendsListsModel(
      friends: json['friends'] != null
          ? List<User>.from(json['friends'].map((userJson) => User.fromJson(userJson)))
          : [], // Check if 'friends' list is not null before mapping
      nonFriends: json['nonFriends'] != null
          ? List<User>.from(json['nonFriends'].map((userJson) => User.fromJson(userJson)))
          : [], // Check if 'nonFriends' list is not null before mapping
    );
  }
}