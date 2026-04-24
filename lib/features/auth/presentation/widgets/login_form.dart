import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_project/app/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/app/core/layout/app_layout.dart';
import 'package:starter_project/app/core/controller/selection_controller.dart';
import 'package:starter_project/app/core/model/selection_item.dart';
import 'package:starter_project/app/core/utils/validators.dart';
import 'package:starter_project/app/core/widgets/Misc/app_rich_text.dart';
import 'package:starter_project/app/core/widgets/app_inputs/app_dropdown.dart';
import 'package:starter_project/app/core/widgets/app_inputs/app_input_label.dart';
import 'package:starter_project/app/core/widgets/app_inputs/app_text_field.dart';
import 'package:starter_project/app/core/widgets/buttons/app_button.dart';
import 'package:starter_project/app/core/widgets/feedbacks/app_popup.dart';
import 'package:starter_project/app/core/widgets/pagination/pagination_state_model.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final controller = SelectionController<String>([]);
  final dropdownFieldController = TextEditingController();

  @override
  void initState() {
    context.read<DemoController>().fetch(isRefresh: true);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DemoController(),
      child: Padding(
        padding: AppLayout.horizontalEdgeInsets(context),
        child: Consumer<DemoController>(
          builder: (context, demoController, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppFieldLabel(text: "Email"),
                2.h,
                AppTextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                  autofillHints: [AutofillHints.email],
                  validator: (value) => Validators.email(value),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                ),
                8.h,

                AppFieldLabel(text: "Password"),
                2.h,

                AppTextField(
                  controller: passwordController,
                  type: AppTextFieldType.password,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  textInputAction: TextInputAction.done,
                  autofillHints: [AutofillHints.password],
                  validator: (value) => Validators.password(value),
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                  },
                ),

                8.h,
                AppFieldLabel(text: "DOB"),
                2.h,

                // ValueListenableBuilder(
                //   valueListenable: controller,
                //   builder: (context, value, child) {
                //     return Wrap(
                //       spacing: 8,
                //       runSpacing: 8,
                //       children: [
                //         AppSelectableCard(
                //           item: AppSelectionItem(value: "a", label: "Option A"),
                //           controller: controller,
                //           single: true,
                //         ),
                //         AppSelectableCard(
                //           item: AppSelectionItem(value: "b", label: "Option B"),
                //           controller: controller,
                //           single: true,
                //         ),
                //       ],
                //     );
                //   },
                // ),
                10.h,
                AppDropdown(
                  controller: controller,
                  target: (key) {
                    return ValueListenableBuilder(
                      valueListenable: controller,
                      builder: (context, value, child) {
                        return AppTextField(
                          key: key,
                          controller: dropdownFieldController,
                          type: AppTextFieldType.dropDown,
                        );
                      },
                    );
                  },
                  isSearchEnabled: true,
                  // isMulti: true,
                  items: demoController.state.items,
                  onLoad: ({String? value, bool forceRefresh = false}) async {
                    await demoController.fetch(
                      isRefresh: forceRefresh,
                      searchValue: value,
                    );
                    return demoController.state;
                  },
                  onItemTap: (items) {
                    dropdownFieldController.text = items.join(", ");
                  },
                  // items: [
                  //   AppSelectionItem(value: "apple", label: "Apple"),
                  //   AppSelectionItem(value: "banana", label: "Banana"),
                  //   AppSelectionItem(value: "mango", label: "Mango"),
                  // ],
                ),
                10.h,

                AppRichText(
                  spans: [
                    AppTextSpan(text: "If you don't have any account"),

                    AppTextSpan(
                      text: "Sign up",
                      onTap: () {},
                      style: TextStyle(decoration: TextDecoration.none),
                    ),
                  ],
                ),

                20.h,

                AppButton(
                  text: "Login",
                  onPressed: () async {
                    await AppPopup.showDeleteConfirmation(
                      context,
                      deleteItemName: "your account",
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );

    // Expanded(
    //   child: Consumer<DemoController>(
    //     builder: (context, controller, _) {
    //       final state = controller.state;

    //       return AppPagination(
    //         state: state,
    //         itemBuilder: (context, item, index) {
    //           return ListTile(title: Text(item));
    //         },
    //         onLoadMore: () => controller.fetch(),
    //         onRefresh: () => controller.fetch(isRefresh: true),

    //         builder: (controller, itemBuilder, itemCount) {
    //           return ListView.builder(
    //             shrinkWrap: true,
    //             controller: controller,
    //             itemBuilder: itemBuilder,
    //             itemCount: itemCount,
    //           );
    //         },
    //       );
    //     },
    //   ),
    // );
  }
}

class DemoController extends ChangeNotifier {
  PaginationState<AppSelectionItem<String, String>> state =
      const PaginationState(items: [], isLoading: false, isLastPage: false);

  int _page = 1;
  final int _limit = 10;
  int _total = 0;
  late final List<AppSelectionItem<String, String>> _allItems = List.generate(
    100,
    (i) {
      return AppSelectionItem(id: "value_$i", data: "Label $i");
    },
  );

  Future<void> fetch({bool isRefresh = false, String? searchValue}) async {
    try {
      // 🔹 Normalize search
      final query = searchValue?.toLowerCase().trim();

      // 🔹 Handle refresh / new search
      if (isRefresh || state.items.isEmpty) {
        _page = 1;

        state = state.copyWith(
          items: [],
          isLoading: true,
          isLastPage: false,
          hasError: false,
          hasLoadMoreError: false,
        );
      } else if (state.hasLoadMoreError) {
        state = state.copyWith(hasLoadMoreError: false);
        notifyListeners();
      }

      await Future.delayed(const Duration(milliseconds: 500));

      // 🔍 Apply search filter
      final filteredList = query == null || query.isEmpty
          ? _allItems
          : _allItems.where((item) {
              return item.data.toLowerCase().contains(query);
            }).toList();

      _total = filteredList.length;

      // 🔹 Pagination slicing
      final start = (_page - 1) * _limit;
      final end = start + _limit;

      final responseItems = filteredList.sublist(
        start,
        end > filteredList.length ? filteredList.length : end,
      );

      final updatedItems = _page == 1
          ? responseItems
          : [...state.items, ...responseItems];

      final isLastPage = updatedItems.length >= _total;

      state = state.copyWith(
        items: updatedItems,
        isLoading: false,
        isLastPage: isLastPage,
      );

      _page++;

      notifyListeners();
    } catch (e) {
      if (state.items.isEmpty) {
        state = state.copyWith(isLoading: false, hasError: true);
      } else {
        state = state.copyWith(isLoading: false, hasLoadMoreError: true);
      }

      notifyListeners();
    }
  }
}
