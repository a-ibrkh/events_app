import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../../../core/utils/app_textstyles.dart';

class WeekdaysWidget extends StatelessWidget {
  const WeekdaysWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
          AppConstants.weekdaysShort.length,
          (index) => SizedBox(
                width: (MediaQuery.of(context).size.width - 56.0) / 7,
                child: Text(
                  AppConstants.weekdaysShort[index],
                  style: AppTextStyles.smallTitle.copyWith(color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
              )),
    );
  }
}
