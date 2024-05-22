import 'dart:math';

class TemplatesState {

  String viewKey = getRandomString(10);

  TemplatesState(this.viewKey);

  TemplatesState init() {
    return TemplatesState(getRandomString(10));
  }

  TemplatesState clone() {
    return TemplatesState(getRandomString(10));
  }

  TemplatesState update() {
    return TemplatesState(getRandomString(10));
  }


}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
