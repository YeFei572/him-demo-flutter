class MsgResp {
  MsgResp({
    required this.type,
    required this.message,
    required this.user,
    required this.createTime,
  });
  late final int type;
  late final Message message;
  late final User user;
  late final String createTime;

  MsgResp.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = Message.fromJson(json['message']);
    user = User.fromJson(json['user']);
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['message'] = message.toJson();
    _data['user'] = user.toJson();
    _data['createTime'] = createTime;
    return _data;
  }
}

class Message {
  Message({
    required this.receiveId,
    required this.msgContent,
  });
  late final int receiveId;
  late final String msgContent;

  Message.fromJson(Map<String, dynamic> json) {
    receiveId = json['receiveId'];
    msgContent = json['msgContent'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['receiveId'] = receiveId;
    _data['msgContent'] = msgContent;
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
