import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:routemaster/routemaster.dart';
import 'package:routemaster/src/trie_router/trie_router.dart';

MaterialPage<void> builder(RouteData info) {
  return MaterialPage<void>(child: Container());
}

void main() {
  test('Provides correct path without query string', () {
    final data =
        RouteData.fromRouterResult(RouterResult(builder, {}, '/path'), '/path');
    expect(data.path, '/path');
  });

  test('Provides correct path with query string', () {
    final data = RouteData.fromRouterResult(
        RouterResult(builder, {}, '/path'), '/path?hello=world');
    expect(data.path, '/path?hello=world');
  });

  test('Route info with different paths are not equal', () {
    final one = RouteData.fromRouterResult(
        RouterResult(builder, {}, '/one'), '/one/two');
    final two =
        RouteData.fromRouterResult(RouterResult(builder, {}, '/two'), '/one');

    expect(one == two, isFalse);
  });

  test('Route info with same paths are equal', () {
    final one = RouteData.fromRouterResult(RouterResult(builder, {}, '/'), '/');
    final two = RouteData.fromRouterResult(RouterResult(builder, {}, '/'), '/');

    expect(one == two, isTrue);
  });

  test('Route info with different query strings are not equal', () {
    final one =
        RouteData.fromRouterResult(RouterResult(builder, {}, '/'), '/?a=b');
    final two = RouteData.fromRouterResult(RouterResult(builder, {}, '/'), '/');

    expect(one == two, isFalse);
  });

  test('Route info with same query strings are equal', () {
    final one =
        RouteData.fromRouterResult(RouterResult(builder, {}, '/'), '/?a=b');
    final two =
        RouteData.fromRouterResult(RouterResult(builder, {}, '/'), '/?a=b');

    expect(one == two, isTrue);
  });

  test('Route info with same path params are equal', () {
    final one =
        RouteData.fromRouterResult(RouterResult(builder, {'a': 'b'}, '/'), '/');
    final two =
        RouteData.fromRouterResult(RouterResult(builder, {'a': 'b'}, '/'), '/');

    expect(one == two, isTrue);
  });

  test('RouteData.toString() is correct', () {
    expect(
      RouteData('/').toString(),
      "RouteData: '/'",
    );
  });
}
