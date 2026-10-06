import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Font helpers for the families used in the design
/// (Cairo, Almarai, Tajawal, Amiri, Poppins).
TextStyle cairo(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color? color,
  double? height,
}) => GoogleFonts.cairo(
  fontSize: size,
  fontWeight: weight,
  color: color ?? AppColors.text,
  height: height,
);

TextStyle almarai(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color? color,
  double? height,
}) => GoogleFonts.almarai(
  fontSize: size,
  fontWeight: weight,
  color: color ?? AppColors.text,
  height: height,
);

TextStyle tajawal(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color? color,
  double? height,
}) => GoogleFonts.tajawal(
  fontSize: size,
  fontWeight: weight,
  color: color ?? AppColors.text,
  height: height,
);

TextStyle amiri(double size, {Color? color, double? height}) =>
    GoogleFonts.amiri(
      fontSize: size,
      color: color ?? AppColors.text,
      height: height,
    );

TextStyle poppins(double size, {Color? color, double? height}) =>
    GoogleFonts.poppins(
      fontSize: size,
      color: color ?? AppColors.text,
      height: height,
    );

const bold = FontWeight.w700;
const extraBold = FontWeight.w800;
const semiBold = FontWeight.w600;
