class ApiEndPoints {
  // static final String baseUrl = 'http://127.0.0.1:8000/api/';
  static final String baseUrl = 'https://dona-link.dermaone.my.id/api/';
  static final String baseUrlImage = 'https://dona-link.dermaone.my.id';
  // static final String baseUrlImage = 'https://suryamarket.org';
  // static final String baseUrl = 'https://suryamarket.org/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'member/register';
  final String loginEmail = 'member/login';
}
