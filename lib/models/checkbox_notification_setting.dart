class CheckboxNotificationSetting {
  int id;
  String title;
  bool value;

  CheckboxNotificationSetting({
    required this.id,
    required this.title,
    this.value = false,
});
}