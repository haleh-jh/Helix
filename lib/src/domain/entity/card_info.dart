import 'package:flutter/material.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';

class TotalInfo {
  final String? svgSrc, title;
  final Color? color;
  final IconData? icon;

  TotalInfo({
    this.icon,
    this.svgSrc,
    this.title,
    this.color,
  });
}

List MainObjectInfo = [
  TotalInfo(
    title: "Telescopes",
    svgSrc: "assets/icons/Documents.svg",
    color: primaryColor,
  ),
  TotalInfo(
    title: "Detectors",
    svgSrc: "assets/icons/google_drive.svg",
    color: kInfoCardOrange,
  ),
  TotalInfo(
    title: "Objects",
    svgSrc: "assets/icons/one_drive.svg",
    color: kInfoCardLightBlue,
  ),
  TotalInfo(
    title: "Filters",
    svgSrc: "assets/icons/drop_box.svg",
    color: kInfoCardDarkBlue,
  ),
];

List OtherObjectInfo = [
  TotalInfo(
    title: "Coordinate ra",
    svgSrc: "assets/icons/Documents.svg",
    color: kInfoCardOrange,
    icon: Icons.calculate,
  ),
  TotalInfo(
    title: "Coordinate dec",
    svgSrc: "assets/icons/google_drive.svg",
    color: kInfoCardOrange,
    icon: Icons.circle,
  ),
  TotalInfo(
    title: "Radius",
    svgSrc: "assets/icons/one_drive.svg",
    color: kInfoCardOrange,
    icon: Icons.circle,
  ),
  TotalInfo(
    title: "User",
    svgSrc: "assets/icons/drop_box.svg",
    color: primaryColor,
    icon: Icons.person_rounded,
  ),
];

List ObservationDetailInfo = [
  TotalInfo(
    title: "Telescopes",
    svgSrc: "assets/icons/Documents.svg",
    color: primaryColor,
  ),
  TotalInfo(
    title: "Detectors",
    svgSrc: "assets/icons/google_drive.svg",
    color: kInfoCardOrange,
  ),
  TotalInfo(
    title: "Objects",
    svgSrc: "assets/icons/one_drive.svg",
    color: kInfoCardLightBlue,
  ),
  TotalInfo(
    title: "Filters",
    svgSrc: "assets/icons/drop_box.svg",
    color: primaryColor,
  ),
  TotalInfo(
    title: "Type",
    svgSrc: "assets/icons/google_drive.svg",
    color: kInfoCardLightBlue,
  ),
];
