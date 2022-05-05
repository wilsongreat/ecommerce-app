class UserData {
  final String email;
  final String uid;

  const UserData({required this.email, required this.uid});
// Creating userData from a map
  UserData.fromMap(Map<String, dynamic> map)
      : email = map["email"] ?? "",
        uid = map["uid"];

// Convert userData to Map
  Map<String, dynamic> toMap() {
    return {'email': email, 'uid': uid};
  }
}
