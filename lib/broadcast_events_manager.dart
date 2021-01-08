import 'package:broadcast_events/broadcast_events.dart';

typedef BroadcastEventsCallBack<T> = void Function(T event);

class BroadcastEventsManager<T extends EventPublisher> {
  /// 内部构造方法
  BroadcastEventsManager._();

  static BroadcastEventsManager _instance;

  /// 实现工厂构造方法 目的实现单列效果
  factory BroadcastEventsManager() => _instance ??= BroadcastEventsManager._();

  /// 事件总线集合
  Map _streamMap = Map<String, BroadcastEventsStream>();

  /// 获取type类型
  Type _typeOf<T>() => T;

  /// 获取索引key
  String _key<T>({String tag}) {
    return _typeOf<T>().toString() + (tag ?? '');
  }

  /// 添加广播事件
  void add<T extends EventPublisher>(BroadcastEventsCallBack<T> callBack,
      {String tag, bool sync = false}) {
    BroadcastEventsStream busStream;
    String key = _key<T>(tag: tag);

    if (_streamMap.containsKey(key)) {
      busStream = _streamMap[key];
    } else {
      busStream = BroadcastEventsStream(sync: sync);
      _streamMap[key] = busStream;
    }

    /// 流事件监听
    busStream.add<T>().listen(callBack);
  }

  /// 移除广播事件
  void off<T extends EventPublisher>({String tag}) {
    String key = _key<T>(tag: tag);

    if (_streamMap.containsKey(key)) {
      _streamMap[key].destroy();
      _streamMap.remove(key);
    }
  }

  /// 执行广播事件
  void post<T extends EventPublisher>(T event, {String tag}) {
    String key = _key<T>(tag: tag);

    if (_streamMap.containsKey(key)) {
      _streamMap[key].post(event);
    }
  }
}
