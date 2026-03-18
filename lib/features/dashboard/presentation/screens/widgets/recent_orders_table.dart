import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/dashboard/presentation/table/table_source.dart';

class RecentOrdersTable extends StatelessWidget {
  const RecentOrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwSections),
          TPaginatedDataTable(
            minWidth: 700,
            tableHeight: 400, 
            columns: const [
              DataColumn2(label: Text('Order ID')), 
              DataColumn2(label: Text('Date')),
              DataColumn2(label: Text('Items')),
              DataColumn2(label: Text('Status')),
              DataColumn2(label: Text('Amount')),
            ],
            source: OrderRows(context),
          ),
        ],
      ),
    );
  }
}
