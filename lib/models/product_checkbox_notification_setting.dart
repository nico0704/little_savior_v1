class ProductCheckboxNotificationSetting {
  String title;
  bool value;
  DateTime bbd;

  ProductCheckboxNotificationSetting({
    required this.title,
    this.value = false,
    required this.bbd,
  });
}