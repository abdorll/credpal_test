import "package:credpaltest/core/widgets/spacing.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:hive_flutter/hive_flutter.dart';
import "package:flutter/material.dart";
import "package:credpaltest/core/util/app_constansts.dart";
import "package:credpaltest/core/widgets/app_icon.dart";
import "package:credpaltest/core/widgets/app_text.dart";
import "package:credpaltest/core/theme/app_theme.dart";
import "package:credpaltest/core/theme/colors.dart";
import "package:credpaltest/core/util/extensions.dart";
import "package:credpaltest/core/util/utils.dart";

class ChangeThemeScreen extends StatefulWidget {
  static const String changeThemeScreen = "/changeThemeScreen";
  const ChangeThemeScreen({super.key});

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  List<Radio> radioButtons(String theme, Box<dynamic> box) => [
    Radio(
      value: AppConsts.LIGHT_THEME_KEY,
      groupValue: theme,
      onChanged: (value) {
        box.put(AppConsts.THEME_MODE_KEY, value);
      },
    ),
    Radio(
      value: AppConsts.DARK_THEME_KEY,
      groupValue: theme,
      onChanged: (value) {
        box.put(AppConsts.THEME_MODE_KEY, value);
      },
    ),
    Radio(
      value: AppConsts.SYSTEM_THEME_KEY,
      groupValue: theme,
      onChanged: (value) {
        box.put(AppConsts.THEME_MODE_KEY, value);
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: AppIcon(Icons.arrow_back, size: 25.sp, color: AppColors.white),
        ),
        centerTitle: true,
        title: AppText("Change Theme", 18.sp, 7, color: AppColors.white),
      ),
      body: Builder(
        builder: (context) {
          return ValueListenableBuilder<Box>(
            valueListenable: Utils.appCacheBox!.listenable(),
            builder: (context, box, widget) {
              String theme = box.get(
                AppConsts.THEME_MODE_KEY,
                defaultValue: AppConsts.SYSTEM_THEME_KEY,
              );
              return Column(
                children: [
                  ...List.generate(
                    2,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                        vertical: 5.sp,
                      ).copyWith(bottom: 0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child:
                                index == 0
                                    ? radioButtons(theme, box)[0]
                                    : radioButtons(theme, box)[1],
                          ),
                          Expanded(
                            flex: 11,
                            child: InkWell(
                              enableFeedback: false,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                index == 0
                                    ? box.put(
                                      AppConsts.THEME_MODE_KEY,
                                      radioButtons(theme, box)[0].value,
                                    )
                                    : box.put(
                                      AppConsts.THEME_MODE_KEY,
                                      radioButtons(theme, box)[1].value,
                                    );
                              },
                              child: Row(
                                children: [
                                  AppText(
                                    "${index == 0 ? "Light" : "Dark"} Mode",
                                    15.sp,
                                    4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: AppTheme.colorScheme(context).onSecondary),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ).copyWith(bottom: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: radioButtons(theme, box)[2]),
                        Expanded(
                          flex: 11,
                          child: InkWell(
                            enableFeedback: false,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              await box.put(
                                AppConsts.THEME_MODE_KEY,
                                radioButtons(theme, box)[2].value,
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText("System Default", 15.sp, 4),
                                YMargin(10.sp),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppText(
                                        "Switch to \"System Default\" for a seamless look that matches your device settings.",
                                        12.5.sp,
                                        4,
                                        color:
                                            AppTheme.colorScheme(
                                              context,
                                            ).onSecondary,
                                        align: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
