import 'dart:math';

class ApplicationsState {
  String viewKey = getRandomString(10);

  ApplicationsState(this.viewKey);

  ApplicationsState init() {
    return ApplicationsState(getRandomString(10));
  }

  ApplicationsState clone() {
    return ApplicationsState(getRandomString(10));
  }

  ApplicationsState update() {
    return ApplicationsState(getRandomString(10));
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
