import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';

class ProductBasicInfoCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const ProductBasicInfoCard({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Information',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwSections),
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Product Title'),
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Title is required' : null,
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Product Description'),
            maxLines: 5,
            minLines: 5,
          ),
        ],
      ),
    );
  }
}
