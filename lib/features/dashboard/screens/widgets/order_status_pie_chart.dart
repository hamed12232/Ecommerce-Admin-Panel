import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/circular_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final orderStatusData = {
      OrderStatus.delivered: 7,
      OrderStatus.shipped: 5,
      OrderStatus.pending: 26,
      OrderStatus.cancelled: 4,
      OrderStatus.processing: 3,
    };

    final totalAmounts = {
      OrderStatus.delivered: 5980.50,
      OrderStatus.shipped: 623.30,
      OrderStatus.pending: 111777.88,
      OrderStatus.cancelled: 25773.16,
      OrderStatus.processing: 1276.70,
    };

    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Orders Status',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Pie Chart
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: orderStatusData.entries.map((entry) {
                  final status = entry.key;
                  final count = entry.value;
                  return PieChartSectionData(
                    color: THelperFunctions.getOrderStatusColor(status),
                    value: count.toDouble(),
                    title: count.toString(),
                    radius: 80,
                    titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: TColors.white),
                  );
                }).toList(),
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          // Data Table like summary
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Orders')),
                DataColumn(label: Text('Total')),
              ],
              rows: orderStatusData.entries.map((entry) {
                final status = entry.key;
                final count = entry.value;
                final total = totalAmounts[status] ?? 0.0;
                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          TCircularContainer(
                            width: 20,
                            height: 20,
                            backgroundColor:
                                THelperFunctions.getOrderStatusColor(status),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: Text(status.name.replaceFirst(
                                status.name[0], status.name[0].toUpperCase())),
                          ),
                        ],
                      ),
                    ),
                    DataCell(Text(count.toString())),
                    DataCell(Text('\$${total.toStringAsFixed(1)}')),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
