class User {
  final List<int>? bookmarks;

  const User({this.bookmarks});

 static User fromJson(Map<String, dynamic> json) => User(
    bookmarks: json['bookmarks'] as List<int>,
    );

  Map<String, dynamic> toJson() => {
       'bookmarks': bookmarks
      };
}