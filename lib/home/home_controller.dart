import 'package:flutter_riverpod/flutter_riverpod.dart';

final class HomeController extends StateNotifier<int> {
  HomeController() : super(0);

  void increment() {
    state++;
  }

  static final provider =
      StateNotifierProvider.autoDispose<HomeController, int>(
    (ref) => HomeController(),
  );
}
