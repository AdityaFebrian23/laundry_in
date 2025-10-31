class API {
<<<<<<< HEAD
  static const String HOST = '192.168.100.232'; // ⚠️ gunakan IP Wi-Fi kamu
=======
  static const String HOST = '192.168.100.161'; // IP dari log server Node.js
>>>>>>> 39e93bacd60cb914c974a99f068467b9b275d68e
  static const String BASE_URL = 'http://$HOST:5000/api';
  static const String AUTH = '$BASE_URL/auth';
  static const String USERS = '$BASE_URL/users';
  static const String LAUNDRIES = '$BASE_URL/laundries';
  static const String ORDERS = '$BASE_URL/orders';
  static const String PAYMENTS = '$BASE_URL/payments';
  static const String ADMIN = '$BASE_URL/admin';
}
