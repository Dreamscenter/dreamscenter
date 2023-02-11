import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ConsumingProvider<T extends ChangeNotifier> extends StatelessWidget {
  final T Function(BuildContext context) create;
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  const ConsumingProvider({super.key, required this.create, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: create,
      child: Consumer<T>(builder: builder),
    );
  }
}
