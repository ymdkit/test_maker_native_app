import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SynchronizedButton extends HookConsumerWidget {
  const SynchronizedButton({
    super.key,
    required this.body,
  });

  final Widget body;

  SynchronizedButton.elevated({
    super.key,
    required Widget child,
    required AsyncCallback? onPressed,
    Color? backgroundColor,
  }) : body = _SynchronizedElevatedButton(
          backgroundColor: backgroundColor,
          onPressed: onPressed,
          child: child,
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(onTap: () {}, child: body);
  }
}

class _SynchronizedElevatedButton extends HookConsumerWidget {
  const _SynchronizedElevatedButton({
    required this.child,
    required this.onPressed,
    this.backgroundColor,
  });

  final Widget child;
  final Color? backgroundColor;
  final AsyncCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWorking = useState(false);
    final isMounted = useIsMounted();
    return ElevatedButton(
      onPressed: _onPressedValue(isWorking, isMounted, onPressed),
      child: child,
    );
  }
}

void Function()? _onPressedValue(
  ValueNotifier<bool> isWorking,
  bool Function() isMounted,
  AsyncCallback? onPressed,
) {
  if (isWorking.value) {
    return null;
  }
  if (onPressed == null) {
    return null;
  }
  return () async {
    isWorking.value = true;
    await onPressed.call();
    if (isMounted()) isWorking.value = false;
  };
}
