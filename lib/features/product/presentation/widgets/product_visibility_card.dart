import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';

class ProductVisibilityCard extends StatelessWidget {
  final bool isPublished;
  final void Function(bool) onVisibilityChanged;

  const ProductVisibilityCard({
    super.key,
    required this.isPublished,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.sm),
          RadioListTile<bool>(
            value: true,
            groupValue: isPublished,
            title: const Text('Published'),
            onChanged: (v) {
              if (v != null) onVisibilityChanged(v);
            },
            activeColor: TColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile<bool>(
            value: false,
            groupValue: isPublished,
            title: const Text('Hidden'),
            onChanged: (v) {
              if (v != null) onVisibilityChanged(v);
            },
            activeColor: TColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
