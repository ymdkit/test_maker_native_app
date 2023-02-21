import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';

class AnswerEffectWidget extends HookConsumerWidget {
  const AnswerEffectWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(preferencesStateProvider).themeColor;
    final opacityLevel = useState<double>(1);
    final answerEffectState = ref.watch(answerEffectStateProvider);

    ref.listen(answerEffectStateProvider, (_, next) async {
      opacityLevel.value = 1;
      await Future<void>.delayed(const Duration(milliseconds: 200));
      opacityLevel.value = 0;
    });

    return answerEffectState != null
        ? Column(
            children: [
              AnimatedOpacity(
                opacity: opacityLevel.value,
                duration: const Duration(milliseconds: 750),
                child: Column(
                  children: [
                    Icon(
                      answerEffectState ? Icons.circle_outlined : Icons.close,
                      color: answerEffectState
                          ? themeColor.displayColor()
                          : Colors.grey,
                      size: 120,
                    ),
                    Text(
                      answerEffectState ? '正解' : '不正解',
                      style: TextStyle(
                        color: answerEffectState
                            ? themeColor.displayColor()
                            : Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                onEnd: () {
                  ref.read(answerEffectStateProvider.notifier).state = null;
                },
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

final answerEffectStateProvider =
    StateProvider.autoDispose<bool?>((ref) => null);
