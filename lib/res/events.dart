import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class EventBusEvent{
  String title;
  EventBusEvent(this.title);
}

class HttpRequestEvent{
  bool isRequest;
  HttpRequestEvent(this.isRequest);
}