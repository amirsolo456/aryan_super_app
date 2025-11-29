import 'package:models_package/Base/history.dart';
import 'package:models_package/Base/opened.dart' show Opened;

import '../navigation_query_builder.dart';

abstract class INavigationService {
  String get currentPage;
  Function(int)? onOpenedChange;

  Future<void> gotoAsync(
    String name,
    String address, [
    Map<String, dynamic> parameters = const {},
  ]);

  Future<void> gotoAsyncWithParams<TParams>(
    String name,
    String address,
    TParams parameters,
  );

  Future<void> gotoAsyncSimple(String name, String address);

  Future<void> goBackAsync(String name, String address);

  Future<void> goBackAsyncSimple();

  Future<void> gotoAsyncWithOpened(Opened opened);

  Future<void> signOut();

  Future<void> refreshLast();

  Future<void> goLogin();

  History getGoBackAsync();

  Future<bool> canGoBack();

  Future<void> navigateAndClearStackAsync(
    String address, [
    Map<String, dynamic> parameters = const {},
  ]);

  Future<void> pushModalAsync<TPage>(TPage page);

  Future<void> popModalAsync();

  Future<void> pushAsync<TPage>(TPage page);

  NavigationQueryBuilderService pageBuilder([String? defaultContentView]);
}
