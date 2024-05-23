class ApiExeption implements Exception {
  int code;
  String message;
  ApiExeption(this.code, this.message) {
    if (code == 200) {
      message = 'اتصال اینترنت خود را بررسی کنید';
      return;
    }
    if (code == 201) {
      message = 'محتوایی وجود ندارد';
      return;
    }
    if (code == 400) {
      message = 'این آدرس وجود ندارد';
      return;
    }

    if (code == 401) {
      message = 'شما مجاز به استفاده نیستید';
      return;
    }
    if (code == 403) {
      message = 'شما مجاز به دسترسی نمی باشید';
      return;
    }
    if (code == 500) {
      message = 'سرور دچار مشکل شده است';
      return;
    }
    if (code == 404) {
      message = 'چنین صفحه ای وجود ندارد';
      return;
    }
  }
}
