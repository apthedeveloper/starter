final class AppRegex {
  AppRegex._();

  static final email = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
    r"[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );

  static final strongPassword = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final numbersOnly = RegExp(r'^\d+$');

  static final username = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  static final fullName = RegExp(r'^[a-zA-Z ]+$');

  static final phone = RegExp(r'^\+?[0-9]{10,15}$');

  static final url = RegExp(
    r'^(https?:\/\/)?([\w\-])+\.{1}[a-zA-Z]{2,}(\/\S*)?$',
  );

  static final hexColor = RegExp(r'^#(?:[0-9a-fA-F]{3}){1,2}$');

  static final otp = RegExp(r'^\d{4,6}$');

  static final pinCode = RegExp(r'^\d{4,10}$');

  static final creditCard = RegExp(r'^\d{13,19}$');

  static final ipv4 = RegExp(r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$');

  static final aadhaar = RegExp(r'^\d{12}$');

  static final panCard = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

  static final date = RegExp(
    r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$',
  );

  static final htmlTags = RegExp(r'<[^>]*>');

  static final emoji = RegExp(
    r'(\u00a9|\u00ae|[\u2000-\u3300]|'
    r'\ud83c[\ud000-\udfff]|'
    r'\ud83d[\ud000-\udfff]|'
    r'\ud83e[\ud000-\udfff])',
  );
}
