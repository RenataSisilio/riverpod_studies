import 'package:flutter_riverpod/flutter_riverpod.dart';

final class HomeController extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;

  static final provider = NotifierProvider(() => HomeController());
}
