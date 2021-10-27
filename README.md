本项目要配合后端项目一起使用 [him-demo](https://github.com/YeFei572/him-demo) <br>
感谢[原作者](https://github.com/lmxdawn) <br>


本项目使用`websocket`和`socket`都试过，其中`websocket`可以正常使用，`socket`目前卡在协议头解析的地方，目前部分可以解析，部分解析不了，主要是因为`protobuf`协议不是很精通,导致不知道在消息头上减去多少个字符才能配上默认的编码器。
<br>
两个技术都使用`protobuf`作为通讯协议，netty后端使用自带的协议头解码。
