part of '../../routemaster.dart';

class IndexedPage extends StatefulPage<void> with IndexedRouteMixIn {
  final Widget child;

  @override
  final List<String> paths;

  IndexedPage({
    required this.child,
    required this.paths,
  });

  @override
  PageState createState(Routemaster routemaster, RouteData routeData) {
    return IndexedPageState(this, routemaster, routeData);
  }

  static IndexedPageState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_IndexedPageStateProvider>()!
        .pageState;
  }
}

class _IndexedPageStateProvider extends InheritedNotifier {
  final IndexedPageState pageState;

  _IndexedPageStateProvider({
    required Widget child,
    required this.pageState,
  }) : super(
          child: child,
          notifier: pageState,
        );

  @override
  bool updateShouldNotify(covariant _IndexedPageStateProvider oldWidget) {
    return pageState != oldWidget.pageState;
  }
}

class IndexedPageState extends PageState
    with ChangeNotifier, IndexedPageStateMixIn {
  @override
  final IndexedPage page;

  @override
  final Routemaster routemaster;

  @override
  final RouteData routeData;

  IndexedPageState(
    this.page,
    this.routemaster,
    this.routeData,
  ) {
    _routes = List.filled(page.paths.length, null);
  }
  @override
  Page createPage() {
    // TODO: Provide a way for user to specify something other than MaterialPage
    return MaterialPage<void>(
      child: Builder(builder: (context) {
        return _IndexedPageStateProvider(
          pageState: this,
          child: page.child,
        );
      }),
      key: ValueKey(routeData),
    );
  }
}

class TabPage extends StatefulPage<void> with IndexedRouteMixIn {
  final Widget child;

  @override
  final List<String> paths;

  TabPage({
    required this.child,
    required this.paths,
  });

  @override
  PageState createState(Routemaster routemaster, RouteData routeData) {
    return TabPageState(this, routemaster, routeData);
  }

  static TabPageState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_TabPageStateProvider>()!
        .pageState;
  }
}

class _TabPageStateProvider extends InheritedNotifier {
  final TabPageState pageState;

  _TabPageStateProvider({
    required Widget child,
    required this.pageState,
  }) : super(
          child: child,
          notifier: pageState,
        );

  @override
  bool updateShouldNotify(covariant _TabPageStateProvider oldWidget) {
    return pageState != oldWidget.pageState;
  }
}

class TabPageState extends PageState
    with ChangeNotifier, IndexedPageStateMixIn {
  @override
  final TabPage page;

  @override
  final Routemaster routemaster;

  @override
  final RouteData routeData;

  TabPageState(this.page, this.routemaster, this.routeData) {
    _routes = List.filled(page.paths.length, null);
  }

  @override
  set index(int value) {
    if (_tabController != null) {
      _tabController!.index = value;
    }

    super.index = value;
  }

  @override
  Page createPage() {
    // TODO: Provide a way for user to specify something other than MaterialPage
    return MaterialPage<void>(
      key: ValueKey(routeData),
      child: _TabControllerProvider(
        pageState: this,
        child: Builder(
          builder: (context) {
            return _TabPageStateProvider(
              pageState: this,
              child: Builder(builder: (_) => page.child),
            );
          },
        ),
      ),
    );
  }

  TabController? _tabController;
  TabController get tabController => _tabController!;
}

/// Creates a [TabController] for [TabPageState]
class _TabControllerProvider extends StatefulWidget {
  final Widget child;
  final TabPageState pageState;

  _TabControllerProvider({
    required this.child,
    required this.pageState,
  });

  @override
  _TabControllerProviderState createState() => _TabControllerProviderState();
}

class _TabControllerProviderState extends State<_TabControllerProvider>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    final tabController = TabController(
      length: widget.pageState._routes.length,
      initialIndex: widget.pageState.index,
      vsync: this,
    );

    tabController.addListener(() {
      widget.pageState.index = tabController.index;
    });

    widget.pageState._tabController = tabController;
  }

  @override
  void dispose() {
    widget.pageState._tabController?.dispose();
    widget.pageState._tabController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class CupertinoTabPage extends StatefulPage<void> with IndexedRouteMixIn {
  final Widget child;

  @override
  final List<String> paths;

  CupertinoTabPage({
    required this.child,
    required this.paths,
  });

  @override
  PageState createState(Routemaster routemaster, RouteData routeData) {
    return CupertinoTabPageState(this, routemaster, routeData);
  }

  static CupertinoTabPageState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_CupertinoTabPageStateProvider>()!
        .pageState;
  }
}

class _CupertinoTabPageStateProvider extends InheritedNotifier {
  final CupertinoTabPageState pageState;

  _CupertinoTabPageStateProvider({
    required Widget child,
    required this.pageState,
  }) : super(
          child: child,
          notifier: pageState,
        );

  @override
  bool updateShouldNotify(covariant _CupertinoTabPageStateProvider oldWidget) {
    return pageState != oldWidget.pageState;
  }
}

class CupertinoTabPageState extends PageState
    with ChangeNotifier, IndexedPageStateMixIn {
  @override
  final CupertinoTabPage page;

  @override
  final Routemaster routemaster;

  @override
  final RouteData routeData;

  final CupertinoTabController tabController = CupertinoTabController();

  CupertinoTabPageState(
    this.page,
    this.routemaster,
    this.routeData,
  ) {
    _routes = List.filled(page.paths.length, null);

    addListener(() {
      if (index != tabController.index) {
        tabController.index = index;
      }
    });

    tabController.addListener(() {
      index = tabController.index;
    });
  }

  @override
  Page createPage() {
    // TODO: Provide a way for user to specify something other than MaterialPage
    return MaterialPage<void>(
      child: Builder(
        builder: (context) {
          return _CupertinoTabPageStateProvider(
            pageState: this,
            child: page.child,
          );
        },
        key: ValueKey(routeData),
      ),
    );
  }

  Widget tabBuilder(BuildContext context, int index) {
    final stack = _getStackForIndex(index);
    final pages = stack.createPages();

    assert(pages.isNotEmpty, 'Pages must not be empty');

    return Navigator(
      key: stack.navigatorKey,
      onPopPage: stack.onPopPage,
      pages: pages,
    );
  }
}

mixin IndexedRouteMixIn<T> on Page<T> {
  List<String> get paths;
}

mixin IndexedPageStateMixIn on PageWrapper, ChangeNotifier {
  Routemaster get routemaster;
  late List<PageStack?> _routes;

  @override
  RouteData get routeData;

  IndexedRouteMixIn get page;

  StackList? _stacks;
  StackList get stacks => _stacks ??= StackList(this);

  PageStack get currentStack => _getStackForIndex(index);

  int _index = 0;
  int get index => _index;
  set index(int value) {
    if (value != _index) {
      _index = value;

      notifyListeners();
    }
  }

  PageStack _getStackForIndex(int index) {
    if (_routes[index] == null) {
      final stack = _createInitialStackState(index);
      stack.addListener(notifyListeners);
      _routes[index] = stack;
    }

    return _routes[index]!;
  }

  PageStack _createInitialStackState(int index) {
    final path = join(routeData.path, page.paths[index]);
    final route = routemaster._delegate._getPageForTab(
      _RouteRequest(
        path: path,
        isReplacement: routeData.isReplacement,
      ),
    );
    return PageStack(routes: [route]);
  }

  /// Attempts to handle a list of child pages.
  ///
  /// Checks if the first route matches one of the child paths of this tab page.
  /// If it does, it sets that stack's pages to the routes, and switches the
  /// current index to that tab.
  @override
  bool maybeSetChildPages(Iterable<PageWrapper> pages) {
    assert(
      pages.isNotEmpty,
      "Don't call maybeSetPageStates with an empty list",
    );

    final tabPagePath = routeData.path;
    final subPagePath = pages.first.routeData.path;

    if (!isWithin(tabPagePath, subPagePath)) {
      // subPagePath is not a path beneath the tab page's path.
      return false;
    }

    final index = _getIndexForPath(_stripPath(tabPagePath, subPagePath));
    if (index == null) {
      // First route didn't match any of our child paths, so this isn't a route
      // that we can handle.
      return false;
    }

    // Handle route
    _getStackForIndex(index).maybeSetChildPages(pages.toList());
    this.index = index;
    return true;
  }

  int? _getIndexForPath(String path) {
    var i = 0;
    for (final initialPath in page.paths) {
      if (path.startsWith(initialPath)) {
        return i;
      }
      i++;
    }

    return null;
  }

  static String _stripPath(String parent, String child) {
    final splitParent = split(parent);
    final splitChild = split(child);
    return joinAll(splitChild.skip(splitParent.length));
  }

  @override
  Future<bool> maybePop() {
    return _getStackForIndex(index).maybePop();
  }

  @override
  Iterable<PageWrapper> getCurrentPages() sync* {
    yield this;
    yield* _getStackForIndex(index)._getCurrentPages();
  }
}

class StackList {
  final IndexedPageStateMixIn _indexedPageState;

  StackList(this._indexedPageState);

  PageStack operator [](int index) =>
      _indexedPageState._getStackForIndex(index);
}

class _TabNotFoundPage extends StatelessPage {
  _TabNotFoundPage(String path)
      : super(
          routeData: RouteData(path),
          page: MaterialPage<void>(
            child: DefaultUnknownRoutePage(path: path),
          ),
        );
}
