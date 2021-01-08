# broadcast_events


#### 项目介绍
 **

#### 最完美、最轻量级的广播事件
**

#### 遵守类
```

class MModel with EventPublisher {

  final String name;

  MModel({this.name});

}

```
#### 添加广播事件
```

 BroadcastEventsManager().add<MModel>((event) {
    print('-----${event.name}');
 });
 
 BroadcastEventsManager().add<MModel>((event) {
   print('-----${event.name}');
 },tag: '12');

```

#### 移除广播事件
```

BroadcastEventsManager().off<MModel>();
BroadcastEventsManager().off<MModel>(tag: '12');
 
```

#### 触发广播事件
```

BroadcastEventsManager().post(MModel(name: 'hahhahha'));
BroadcastEventsManager().post(MModel(name: 'hahhahha'),tag: '12');

```
