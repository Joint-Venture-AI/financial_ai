class ApiEndpoint {
  static const String mainBase = 'http://192.168.10.18:5000';

  static const String baseUrl = 'http://192.168.10.18:5000/api';

  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/user/create-user';
  static const String forgotPassword = '$baseUrl/auth/forgot-password-request';
  static const String verifyOtp = '$baseUrl/auth/verify-user';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String updatePassword = '$baseUrl/auth/update-password';
  static const String saveFixedData =
      '$baseUrl/user-expense-plan/add-expense-plan';

  static const String getPresentMonth =
      '$baseUrl/finance-report/get-present-month-summary';
  static const String getCoursesList = '$baseUrl/course?limit=5';
}
