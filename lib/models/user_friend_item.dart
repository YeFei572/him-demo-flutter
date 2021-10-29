class UserFriendItem {
  UserFriendItem({
    required this.uid,
    required this.friendUid,
    required this.remark,
    required this.unMsgCount,
    required this.lastMsgContent,
    required this.modifiedTime,
    required this.user,
  });
  late final int uid;
  late final int friendUid;
  late final String remark;
  late final int unMsgCount;
  late final String lastMsgContent;
  late final String modifiedTime;
  late final User user;

  UserFriendItem.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    friendUid = json['friendUid'];
    remark = json['remark'];
    unMsgCount = json['unMsgCount'];
    lastMsgContent = json['lastMsgContent'];
    modifiedTime = json['modifiedTime'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['friendUid'] = friendUid;
    _data['remark'] = remark;
    _data['unMsgCount'] = unMsgCount;
    _data['lastMsgContent'] = lastMsgContent;
    _data['modifiedTime'] = modifiedTime;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.uid,
    required this.name,
    required this.avatar,
    required this.remark,
  });
  late final int uid;
  late final String name;
  late final String avatar;
  late final String remark;

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    avatar = json['avatar'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['name'] = name;
    _data['avatar'] = avatar;
    _data['remark'] = remark;
    return _data;
  }
}
