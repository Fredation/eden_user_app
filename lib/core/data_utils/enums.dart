enum OrderStatus {
  orderPlaced(
    title: "ORDER PLACED",
    subTitle: "Waiting for vendor to confirm your order",
  ),
  orderAccepted(
    title: "ORDER ACCEPTED",
    subTitle: "Vendor has accepted your order.",
  ),
  orderPickupInProgress(
    title: "ORDER PICK UP IN PROGRESS",
    subTitle: "Rider is on the way to pick up your order.",
  ),
  orderInTransit(
    title: "ORDER ON THE WAY TO CUSTOMER",
    subTitle: "Your order is on its way",
  ),
  orderArrived(
    title: "ORDER ARRIVED",
    subTitle: "Your rider has arrived your location",
  ),
  orderDelivered(
    title: "ORDER DELIVERED",
    subTitle: "Enjoy your meal!",
  );

  final String title;
  final String subTitle;

  const OrderStatus({required this.title, required this.subTitle});
}
