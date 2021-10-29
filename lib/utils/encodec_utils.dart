
import 'dart:typed_data';

///计算数据头的长度
int getLength(int value) {
  if ((value & (0xFFFFFFFF << 7)) == 0) {
    return 1;
  } else if ((value & (0xFFFFFFFF << 14)) == 0) {
    return 2;
  } else if ((value & (0xFFFFFFFF << 21)) == 0) {
    return 3;
  } else {
    return 4;
  }
}

/// 获取protoc buffer data
Uint8List getProtocBufferData(Uint8List data){
  int length = data.length;
  int headerLength = getLength(length);
  List<int> list = [];

  /// 添加头数据
  for (int i = 0; i < headerLength; i++) {
    int element = length >> (i * 7) & 127;
    if (i != headerLength - 1) {
      element = element | 128;
    }
    list.add(element);
  }

  /// 添加body数据
  list.addAll(data);
  return Uint8List.fromList(list);
}