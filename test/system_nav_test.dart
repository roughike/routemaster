import 'package:flutter_test/flutter_test.dart';
import 'package:routemaster/routemaster.dart';
import 'package:routemaster/src/system_nav.dart';
import 'package:routemaster/src/system_nav_main.dart';

void main() {
  test('SystemNav.pathStrategy throws when not on web', () {
    expect(() => SystemNav.pathStrategy, throwsA(isA<UnsupportedError>()));
  });

  test('SystemNav.setHash() throws when not on web', () {
    expect(
      () => SystemNav.setHash('', {}),
      throwsA(isA<UnsupportedError>()),
    );
  });

  test('SystemNav.setPathUrlStrategy() throws when not on web', () {
    expect(
      () => SystemNav.setPathUrlStrategy(),
      throwsA(isA<UnsupportedError>()),
    );
  });

  test('Routemaster.setPathUrlStrategy() does nothing when not on web', () {
    Routemaster.setPathUrlStrategy();
  });

  test('isReplacement returns correct values', () {
    expect(isReplacementNavigation('blah'), isFalse);

    expect(isReplacementNavigation({'state': null}), isFalse);

    expect(
      isReplacementNavigation({'state': null}),
      isFalse,
    );

    expect(
      isReplacementNavigation({
        'state': {'isReplacement': null}
      }),
      isFalse,
    );

    expect(
      isReplacementNavigation({
        'state': {'isReplacement': false}
      }),
      isFalse,
    );

    expect(
      isReplacementNavigation({
        'state': {'isReplacement': true}
      }),
      isTrue,
    );
  });
}
