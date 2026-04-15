import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/segment_button.dart';

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
          SegmentButton<bool>(
            selected: {isPublished},
            segments: const [
              ButtonSegment(value: true, label: Text('Published')),
              ButtonSegment(value: false, label: Text('Hidden')),
            ],
            onSelectionChanged: (selected) {
              onVisibilityChanged(selected.first);
            },
          ),
        ],
      ),
    );
  }
}
