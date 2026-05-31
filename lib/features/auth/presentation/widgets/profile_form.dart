import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/core/utils/validators.dart';
import 'package:starter_project/features/auth/presentation/controller/auth.provider.dart';
import 'package:starter_project/gen/assets.gen.dart';
import 'package:starter_project/shared/controllers/selection.controller.dart';
import 'package:starter_project/features/auth/domain/enums/gender.enum.dart';
import 'package:starter_project/shared/models/selectable_item.dart';
import 'package:starter_project/shared/services/media_selector_service.dart';
import 'package:starter_project/shared/widgets/buttons/app_button.dart';
import 'package:starter_project/shared/widgets/feedbacks/app_sheet.dart';
import 'package:starter_project/shared/widgets/feedbacks/app_snackbar.dart';
import 'package:starter_project/shared/widgets/inputs/app_input_label.dart';
import 'package:starter_project/shared/widgets/inputs/app_selectable_chip.dart';
import 'package:starter_project/shared/widgets/inputs/app_text_field.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/shared/widgets/sections/app_image.dart';

class ProfileForm extends ConsumerStatefulWidget {
  const ProfileForm({super.key});

  @override
  ConsumerState<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<ProfileForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final dobFocusNode = FocusNode();
  bool forceNoOnFocus = false;

  late SelectionController<String> genderController;

  final selectedProfileImageNotifier = ValueNotifier<XFile?>(null);

  @override
  void initState() {
    super.initState();
    genderController = SelectionController<String>([]);
    // Pre-fill email if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prefillEmail();
    });
  }

  void _prefillEmail() {
    final user = ref.read(authControllerProvider).userState.data;

    emailController.text = user?.email ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    dobController.dispose();
    emailController.dispose();
    genderController.dispose();
    dobFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    final pickedFile = await AppSheet.showMediaPicker(
      context: context,
      isVideo: false,
    );

    if (pickedFile != null) {
      final croppedFile = await MediaPickerService.cropImage(
        pickedFile.path,
        // ignore: use_build_context_synchronously
        context.colors,
        cropStyle: .circle,
        lockAspectRatio: true,
      );
      if (croppedFile != null) {
        selectedProfileImageNotifier.value = croppedFile;
      }
    }
  }

  Future<void> _selectDate() async {
    if (forceNoOnFocus) {
      dobFocusNode.unfocus();
      forceNoOnFocus = false;
      return;
    }
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    dobFocusNode.nextFocus();
    if (pickedDate != null) {
      dobController.text = pickedDate.toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final genderOptions = Gender.values
        .where((gender) => gender != Gender.unknown)
        .map(
          (gender) => SelectableItem<String, String>(
            id: gender.apiValue,
            data: gender.localizedName(context),
          ),
        )
        .toList();

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture Selection
          Center(
            child: GestureDetector(
              onTap: _pickProfileImage,
              child: ValueListenableBuilder(
                valueListenable: selectedProfileImageNotifier,
                builder: (context, selectedProfileImage, child) {
                  return AppImage.file(
                    width: 120,
                    height: 120,
                    shape: BoxShape.circle,
                    backgroundColor: context.colors.borderLight,
                    borderRadius: BorderRadius.circular(999),
                    file: File(selectedProfileImage?.path ?? ''),
                    fallbackImage: AssetImage(
                      Assets.icons.placeholders.profile.path,
                    ),
                  );
                },
              ),
            ),
          ),
          30.h,

          // Name Field
          AppFieldLabel(text: context.localizations.fullNameLabel),
          2.h,
          AppTextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: context.localizations.fullNameHint,
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) => Validators.required(
              context,
              value,
              fieldName: context.localizations.fullNameLabel,
            ),
            textInputAction: TextInputAction.next,
          ),
          16.h,

          // Bio Field
          AppFieldLabel(text: context.localizations.bioLabel),
          2.h,
          AppTextField(
            controller: bioController,

            // customPrefixIcon: Icon(Icons.description),
            decoration: InputDecoration(
              hintText: context.localizations.bioHint,
              alignLabelWithHint: true,

              prefixIcon: Padding(
                padding: EdgeInsets.only(bottom: 44),
                child: Icon(Icons.description),
              ),
            ),
            maxLines: 3,
            textInputAction: TextInputAction.next,
          ),
          16.h,

          // Date of Birth Field
          AppFieldLabel(text: context.localizations.dobLabel),
          2.h,
          AppTextField(
            controller: dobController,
            type: AppTextFieldType.date,
            readOnly: true,
            focusNode: dobFocusNode,
            decoration: InputDecoration(
              hintText: context.localizations.dobHint,
              prefixIcon: Icon(Icons.calendar_today),
            ),
            onFocus: _selectDate,
            validator: (value) => Validators.required(context, value),
            textInputAction: TextInputAction.next,
          ),
          16.h,

          // Gender Selection
          AppFieldLabel(text: context.localizations.genderLabel),
          8.h,
          ValueListenableBuilder(
            valueListenable: genderController,
            builder: (context, value, child) {
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final gender in genderOptions)
                    AppSelectableChip(
                      item: gender,
                      controller: genderController,
                      single: true,
                    ),
                ],
              );
            },
          ),
          16.h,

          // Email Field (Disabled)
          AppFieldLabel(text: context.localizations.emailLabel),
          2.h,
          AppTextField(
            controller: emailController,
            enabled: false,
            decoration: InputDecoration(
              hintText: context.localizations.emailAddressHint,
              prefixIcon: Icon(Icons.email),
            ),
          ),
          40.h,

          // Submit Button
          Consumer(
            builder: (context, ref, child) {
              final isLoading = ref.watch(
                authControllerProvider.select((s) => s.userState.isLoading),
              );

              return AppButton(
                text: context.localizations.completeProfileTitle,
                isLoading: isLoading,
                fullWidth: true,
                onPressed: () async {
                  forceNoOnFocus = true;
                  if (!(formKey.currentState?.validate() ?? false)) {
                    AppSnackbar.error(
                      context.localizations.fillRequiredFieldsError,
                    );
                    return;
                  }

                  if (genderController.value.isEmpty) {
                    AppSnackbar.error(context.localizations.selectGenderError);
                    return;
                  }
                  if (selectedProfileImageNotifier.value?.path == null) {
                    AppSnackbar.error(
                      context.localizations.selectProfileImageError,
                    );
                    return;
                  }

                  ref
                      .read(authControllerProvider.notifier)
                      .completeProfile(
                        name: nameController.text,
                        bio: bioController.text,
                        dateOfBirth: dobController.text,
                        gender: genderController.value.first,
                        profileImagePath:
                            selectedProfileImageNotifier.value!.path,
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
