import 'package:flutter/material.dart';

// 팝업 메뉴 항목을 생성하는 함수
PopupMenuItem<int> buildPopupMenuItem({
  required String title,
  required IconData? iconData,
  required int value,
}) {
  return PopupMenuItem<int>(
    value: value,
    child: Row(
      children: [
        if (iconData != null)
          Icon(
            iconData,
          ),
        const SizedBox(width: 8),
        Text(title),
      ],
    ),
  );
}
