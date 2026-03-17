import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';

class WeeklySalesGraph extends StatelessWidget {
  const WeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data to match the visual representation
    final List<double> weeklySales = [240, 360, 230, 350, 150, 0, 0];

    return TRoundedContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly Sales',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwSections),
          SizedBox(
            height: 550,
            child: BarChart(
              BarChartData(
                minY: 0,
                maxY: 400,
                titlesData: buildFlTitlesData(),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide(color: TColors.grey),
                      bottom: BorderSide(color: TColors.grey)),
                ),
                gridData: const FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  horizontalInterval: 100,
                ),
                barGroups: weeklySales
                    .asMap()
                    .entries
                    .map(
                      (entry) => BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            width: 25,
                            toY: entry.value,
                            color: TColors.primary,
                            borderRadius: BorderRadius.circular(TSizes.sm),
                          ),
                        ],
                      ),
                    )
                    .toList(),
                groupsSpace: TSizes.spaceBtwItems,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => TColors.secondary,
                  ),
                  touchCallback: TDeviceUtils.isDesktopScreen(context)
                      ? (barTouchEvent, barTouchResponse) {}
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
            final DateTime startOfWeek = THelperFunctions.getStartOfWeek(DateTime.now());
            final index = value.toInt() % 7;
            final date = startOfWeek.add(Duration(days: index));
            final day = THelperFunctions.getFormattedDate(date, format: 'E');

            return SideTitleWidget(
              meta: meta,
              space: 8,
              child: Text(day,
                  style: const TextStyle(
                      color: TColors.darkGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            );
          },
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 100,
          reservedSize: 40,
        ),
      ),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
