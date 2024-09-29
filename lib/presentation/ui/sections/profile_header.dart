import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/colors.dart';
import '../../../config/spacing.dart';
import '../../../config/text_styles.dart';
import '../../../logic/blocs/profile/data/profile.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;

  const ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(width: 0.5, color: AppColors.accent)),
      child: ListTile(
        leading: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("NAME",
                style:
                AppTextStyles.caption.copyWith(color: AppColors.onPrimary)),
            const SizedBox(height: AppSpacing.small),
            Text(profile.name,
                style: AppTextStyles.bodyTextSmall
                    .copyWith(color: AppColors.onPrimary))
          ],
        ),
        title: Row(
          children: [
            const SizedBox(width: AppSpacing.large),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("RATING",
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.onPrimary)),
                const SizedBox(height: AppSpacing.small),
                Text('${profile.rating}',
                    style: AppTextStyles.bodyTextSmall
                        .copyWith(color: AppColors.onPrimary)),
              ],
            )
          ],
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("RANK",
                style:
                AppTextStyles.caption.copyWith(color: AppColors.onPrimary)),
            const SizedBox(height: AppSpacing.small),
            Text('${profile.rank}',
                style: AppTextStyles.bodyTextSmall
                    .copyWith(color: AppColors.onPrimary))
          ],
        ),
      ),
    );
  }
}
