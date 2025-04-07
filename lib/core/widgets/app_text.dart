// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:credpaltest/core/theme/app_theme.dart';

/// ==============================[Text Widget]===================
/// ==============================[Text Widget]===================
/// ==============================[Text Widget]===================
class AppText extends StatelessWidget {
  AppText(
    this.text,
    this.size,
    this.weight, {
    this.align = TextAlign.center,
    this.textOverflow = TextOverflow.visible,
    this.color,
    this.maxLines,
    this.decorationThickness,
    this.height,
    this.fontStyle,
    this.decoration = TextDecoration.none,
    this.letterSpacing = 0,
    this.wordSpacing = 0,
    super.key,
  });
  String text;

  Color? color;
  TextAlign align;
  double? size, height;
  TextDecoration decoration;
  FontStyle? fontStyle;
  int? weight, maxLines;
  double? wordSpacing, letterSpacing, decorationThickness;

  TextOverflow textOverflow;

  TextStyle textStyle(BuildContext context) {
    assert(
      AppTheme.fontWeight.containsKey(weight),
      "Only font weight 0-10 is allowed",
    );
    return GoogleFonts.mulish(
      wordSpacing: wordSpacing,
      height: height,
      fontStyle: fontStyle,
      decorationColor: color ?? AppTheme.colorScheme(context).primary,
      decoration: decoration,
      color: color ?? AppTheme.colorScheme(context).primary,
      fontSize: size,
      decorationThickness: decorationThickness,
      letterSpacing: letterSpacing,
      fontWeight: AppTheme.fontWeight[weight ?? 4],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: align,
      textHeightBehavior: TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      ),
      overflow: textOverflow,
      style: textStyle(context),
    );
  }
}

/// ==============================[Animated Text Widget]===================
/// ==============================[Animated Text Widget]===================
/// ==============================[Animated Text Widget]===================
class AppAnimatedText extends StatelessWidget {
  AppAnimatedText(
    this.text,
    this.size,
    this.weight, {
    required this.duration,
    this.align = TextAlign.center,
    this.textOverflow = TextOverflow.visible,
    this.color,
    this.maxLines,
    this.height,
    this.curves,
    this.fontStyle,
    this.decoration = TextDecoration.none,
    this.letterSpacing = 0,
    this.wordSpacing = 0,
    super.key,
  });
  String text;
  Duration duration;
  Color? color;
  TextAlign align;
  double? size, height;

  TextDecoration decoration;
  FontStyle? fontStyle;
  int? weight, maxLines;
  double? wordSpacing;
  double? letterSpacing;

  TextOverflow textOverflow;
  Curve? curves;
  @override
  Widget build(BuildContext context) {
    assert(
      AppTheme.fontWeight.containsKey(weight),
      "Only font weight 0-10 is allowed",
    );
    return AnimatedDefaultTextStyle(
      duration: duration,
      curve: curves ?? Curves.easeInOut,
      style: GoogleFonts.montserrat(
        wordSpacing: wordSpacing,
        height: height,
        fontStyle: fontStyle,
        decorationColor: color ?? AppTheme.colorScheme(context).primary,
        decoration: decoration,
        color: color ?? AppTheme.colorScheme(context).primary,
        fontSize: size!,
        letterSpacing: letterSpacing,
        fontWeight: AppTheme.fontWeight[weight ?? 4],
      ),
      child: Text(
        text,
        maxLines: maxLines,
        textAlign: align,
        textHeightBehavior: TextHeightBehavior(
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: false,
        ),
        overflow: textOverflow,
      ),
    );
  }
}
