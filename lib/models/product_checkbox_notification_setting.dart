class ProductCheckboxNotificationSetting {
  String title;
  bool value;
  int expiry;
  DateTime bbd;
  int id;

  ProductCheckboxNotificationSetting({
    required this.title,
    this.value = false,
    required this.expiry,
    required this.bbd,
    required this.id,
  });
}