class UserLoginRes {
  UserLoginRes({
    required this.uid,
    required this.sid,
    required this.name,
    required this.avatar,
  });
  late final int uid;
  late final String sid;
  late final String name;
  late final String avatar;

  UserLoginRes.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    sid = json['sid'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['sid'] = sid;
    _data['name'] = name;
    _data['avatar'] = avatar;
    return _data;
  }
}
