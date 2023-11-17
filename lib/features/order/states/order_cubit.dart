import 'dart:async';
import 'dart:developer';

import 'package:eden_user_app/core/data_utils/enums.dart';
import 'package:eden_user_app/core/error/failure.dart';
import 'package:eden_user_app/features/order/data/models/product_model.dart';
import 'package:eden_user_app/features/order/data/models/timelines.dart';
import 'package:eden_user_app/features/order/presentation/widgets/stepper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;

part 'order_cubit.freezed.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState());
  final clientOptions = ably.ClientOptions(
      key: 'iZiugw.v1Natg:_Mg0bT5a6PZ_MIPcH1QyFSjISByc_lKegACELDAcy50');
  late ably.Realtime realtime;

  Object? orderStatus;
  List<TimeLineModel> timelines = [];
  List<Step> defaultSteps = [
    Step(
      title: OrderStatus.orderPlaced.title,
      subtitle: OrderStatus.orderPlaced.subTitle,
      time: "",
    ),
    Step(
      title: OrderStatus.orderAccepted.title,
      subtitle: OrderStatus.orderAccepted.subTitle,
      time: "",
    ),
    Step(
      title: OrderStatus.orderPickupInProgress.title,
      subtitle: OrderStatus.orderPickupInProgress.subTitle,
      time: "",
    ),
    Step(
      title: OrderStatus.orderInTransit.title,
      subtitle: OrderStatus.orderInTransit.subTitle,
      time: "",
    ),
    Step(
      title: OrderStatus.orderArrived.title,
      subtitle: OrderStatus.orderArrived.subTitle,
      time: "",
    ),
    Step(
      title: OrderStatus.orderDelivered.title,
      subtitle: OrderStatus.orderDelivered.subTitle,
      time: "",
    ),
  ];

  final List<ProductModel> products = [
    ProductModel(
      name: "Morocco Tagine",
      amount: 10000,
      image:
          "http://www.cheatsheet.com/wp-content/uploads/2015/02/Baked-chicken-with-chickpeas-and-vegetables.jpg",
      quantity: 1,
    ),
    ProductModel(
      name: "Spaghetti",
      amount: 8000,
      image:
          "https://www.eatthis.com/wp-content/uploads/sites/4/2019/09/spaghetti-meatballs.jpg?quality=82&strip=1",
      quantity: 1,
    ),
    ProductModel(
      name: 'Czech Goulash"',
      amount: 14000,
      image:
          "http://www.cheatsheet.com/wp-content/uploads/2015/11/Goulash-hungarian-beef-stew.jpg",
      quantity: 1,
    ),
    ProductModel(
      name: "Costa Rica Gallo Pinto",
      amount: 12000,
      image: "https://astelus.com/wp-content/viajes/Gallo-pinto-CR.jpg",
      quantity: 1,
    ),
    ProductModel(
      name: "African Native Salad",
      amount: 5000,
      image: "https://i.ytimg.com/vi/0bojPYzHvY8/maxresdefault.jpg",
      quantity: 1,
    ),
  ];

  num getProductTotal() {
    final total = products.fold(
        0, (num previousValue, element) => element.amount + previousValue);
    return total;
  }

  num getVatCharge() {
    final vat = getProductTotal() * 0.075;
    return vat;
  }

  void initAplyRealtime() async {
    realtime = ably.Realtime(options: clientOptions);
    listenRealtimeConnection(realtime);
  }

  StreamSubscription<ably.ConnectionStateChange> listenRealtimeConnection(
      ably.Realtime realtime) {
    //One can listen from multiple listeners on the same event,
    // and must cancel each subscription one by one
    //RETAINING LISTENER - α
    return realtime.connection
        .on(ably.ConnectionEvent.connected)
        .listen((ably.ConnectionStateChange stateChange) async {
      log('New state is: ${stateChange.current}');
      switch (stateChange.current) {
        case ably.ConnectionState.initialized:
          // Initial connection
          log('Initialized!');
          break;
        case ably.ConnectionState.connecting:
          // Connecting
          log('Connecting!');
          break;
        case ably.ConnectionState.connected:
          // Successful connection
          log('RETAINING LISTENER α :: Change event arrived!: ${stateChange.event}'
              '\nReason: ${stateChange.reason}');
          subscribeChannel();
          break;
        case ably.ConnectionState.disconnected:
          // Disconnected
          log('Disconnected!');
          break;
        case ably.ConnectionState.suspended:
          // Suspended
          log('Suspended!');
          break;
        case ably.ConnectionState.failed:
          // Failed connection
          break;
        default:
          break;
      }
    });

    //DISPOSE ON CONNECTED
    // final stream = realtime.connection.on();
    // late StreamSubscription<ably.ConnectionStateChange> omegaSubscription;
    // omegaSubscription = stream.listen((stateChange) async {
    //   log('DISPOSABLE LISTENER ω :: Change event arrived!:'
    //       ' ${stateChange.event}');
    //   if (stateChange.event == ably.ConnectionEvent.connected) {
    //     await omegaSubscription.cancel();
    //   }
    // });
  }

  void subscribeChannel() {
    final channel = realtime.channels.get('order_status');
    channel.subscribe().listen((message) {
      log('Received a greeting message in realtime: ${message.data}');

      if (message.data.toString() != orderStatus) {
        updateTimeline(
            currentStatus: message.data.toString(), time: message.timestamp);
      }
      orderStatus = message.data;
      emit(state.copyWith(data: orderStatus));
    });
  }

  updateTimeline({required String currentStatus, required DateTime? time}) {
    if (currentStatus == OrderStatus.orderPlaced.title) {
      timelines.add(TimeLineModel(
          title: OrderStatus.orderPlaced.title,
          description: OrderStatus.orderPlaced.subTitle,
          time: time));
    }
    if (currentStatus == OrderStatus.orderAccepted.title) {
      timelines.add(TimeLineModel(
          title: OrderStatus.orderAccepted.title,
          description: OrderStatus.orderAccepted.subTitle,
          time: time));
    }
    if (currentStatus == OrderStatus.orderPickupInProgress.title) {
      timelines.add(TimeLineModel(
          title: OrderStatus.orderPickupInProgress.title,
          description: OrderStatus.orderPickupInProgress.subTitle,
          time: time));
    }
    if (currentStatus == OrderStatus.orderInTransit.title) {
      timelines.add(TimeLineModel(
          title: OrderStatus.orderInTransit.title,
          description: OrderStatus.orderInTransit.subTitle,
          time: time));
    }
    if (currentStatus == OrderStatus.orderArrived.title) {
      timelines.add(TimeLineModel(
          title: OrderStatus.orderArrived.title,
          description: OrderStatus.orderArrived.subTitle,
          time: time));
    }
    if (currentStatus == OrderStatus.orderDelivered.title) {
      timelines.add(TimeLineModel(
          title: OrderStatus.orderDelivered.title,
          description: OrderStatus.orderDelivered.subTitle,
          time: time));
    }
    emit(state.copyWith(data: timelines));
  }

  void publishData() async {
    final channel = realtime.channels.get('order_status');
    await channel.publish(name: 'order', data: "ORDER PLACED");
  }
}

@freezed
class OrderState with _$OrderState {
  const factory OrderState({
    @Default(false) isLoading,
    Failure? error,
    dynamic data,
  }) = _OrderState;
}
