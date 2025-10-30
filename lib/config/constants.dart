class API {
  static const String HOST = '192.168.100.161'; // IP dari log server Node.js
  static const String BASE_URL = 'http://$HOST:5000/api';
  static const String AUTH = '$BASE_URL/auth';
  static const String USERS = '$BASE_URL/users';
  static const String LAUNDRIES = '$BASE_URL/laundries';
  static const String ORDERS = '$BASE_URL/orders';
  static const String PAYMENTS = '$BASE_URL/payments';
  static const String ADMIN = '$BASE_URL/admin';
}
