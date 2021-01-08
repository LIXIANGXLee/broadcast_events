import 'dart:async';

/// 事件类型，必须遵守此类
mixin EventPublisher {}

/// 接口文件
abstract class BroadcastEventsInterface<T> {
  /// 触发流事件
  void post<T extends EventPublisher>(T event);

  /// 创建流Stream事件
  Stream<T> add<T extends EventPublisher>();

  /// 关闭当前流事件
  void destroy();
}

class BroadcastEventsStream<T extends EventPublisher>
    implements BroadcastEventsInterface<T> {
  StreamController _streamController;

  /// 创建广播流
  BroadcastEventsStream({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  StreamController get streamController => _streamController;

  @override
  Stream<T> add<T extends EventPublisher>() {
    if (T == dynamic) {
      return _streamController.stream;
    } else {
      return _streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  @override
  void post<T extends EventPublisher>(T event) {
    _streamController.add(event);
  }

  @override
  void destroy() {
    _streamController.close();
  }
}
