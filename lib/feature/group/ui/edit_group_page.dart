import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/group/model/group.dart';
import 'package:test_maker_native_app/feature/group/state/groups_state.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_color_drop_down_button_form_field.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/widget/app_text_form_field.dart';
import 'package:test_maker_native_app/widget/synchronized_button.dart';

class EditGroupPage extends HookConsumerWidget {
  const EditGroupPage({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final workbookTitleController = useTextEditingController(text: group.title);
    final selectedColor = useState(group.color);

    return AppAdWrapper(
      adUnitId: AppAdUnitId.createGroupBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.titleEditGroup,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTextFormField(
                          autofocus: true,
                          controller: workbookTitleController,
                          hintText: AppLocalizations.of(context)!.hintGroupName,
                          labelText:
                              AppLocalizations.of(context)!.labelGroupName,
                          validator: (value) => value?.isEmpty ?? true
                              ? AppLocalizations.of(context)!.hintGroupName
                              : null,
                        ),
                        const SizedBox(height: 16),
                        AppColorDropdownButtonFormField(
                          selectedColor: selectedColor.value,
                          onChanged: (colorTheme) =>
                              selectedColor.value = colorTheme,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SynchronizedButton.elevated(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final result =
                            await ref.read(groupsProvider.notifier).updateGroup(
                                  currentGroup: group,
                                  title: workbookTitleController.text,
                                  color: selectedColor.value,
                                );

                        result.match(
                          (l) => showAppSnackBar(context, l.message),
                          (r) {
                            showAppSnackBar(
                              context,
                              AppLocalizations.of(context)!
                                  .messageUpdateSuccess,
                            );
                            context.router.pop();
                          },
                        );
                      } else {
                        showAppSnackBar(
                          context,
                          AppLocalizations.of(context)!.messageInvalidInput,
                        );
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.buttonUpdate),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
