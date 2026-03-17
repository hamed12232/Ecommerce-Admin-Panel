import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';

class MediaTabletScreen extends StatelessWidget {
  const MediaTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Breadcrumbs
                  TBreadcrumbsWithHeading(
                    heading: 'Media',
                    breadcrumbItems: [AppRoutes.dashboard, AppRoutes.media],
                  ),
                  
                  // TODO: Upload Video/Images CTA button
                ],
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              
              /// Upload Area Container
            ],
          ),
        ),
      ),
    );
  }
}
