import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:yt_ecommerce_admin_panel/features/shop/models/order_model.dart';

class OrderRows extends DataTableSource {
  final BuildContext context;
  
  OrderRows(this.context);

  final List<OrderModel> orders = [
    OrderModel(id: '[#bd757]', orderDate: DateTime(2024, 5, 26), itemsCount: 1, status: OrderStatus.cancelled, totalAmount: 60),
    OrderModel(id: '[#bc90a]', orderDate: DateTime(2024, 5, 20), itemsCount: 1, status: OrderStatus.cancelled, totalAmount: 2560.3),
    OrderModel(id: '[#29381]', orderDate: DateTime(2024, 5, 21), itemsCount: 1, status: OrderStatus.shipped, totalAmount: 13.7),
    OrderModel(id: '[#b9bb2]', orderDate: DateTime(2024, 5, 22), itemsCount: 5, status: OrderStatus.pending, totalAmount: 1098.38),
    OrderModel(id: '[#de37a]', orderDate: DateTime(2024, 5, 23), itemsCount: 1, status: OrderStatus.cancelled, totalAmount: 445),
    OrderModel(id: '[#de695]', orderDate: DateTime(2024, 5, 19), itemsCount: 1, status: OrderStatus.pending, totalAmount: 71),
    OrderModel(id: '[#7e090]', orderDate: DateTime(2024, 5, 21), itemsCount: 2, status: OrderStatus.processing, totalAmount: 863),
    OrderModel(id: '[#4f713]', orderDate: DateTime(2024, 5, 15), itemsCount: 1, status: OrderStatus.processing, totalAmount: 370.2),
    OrderModel(id: '[#8674b]', orderDate: DateTime(2024, 4, 30), itemsCount: 1, status: OrderStatus.delivered, totalAmount: 260.2),
    OrderModel(id: '[#86a73]', orderDate: DateTime(2024, 3, 30), itemsCount: 1, status: OrderStatus.shipped, totalAmount: 49),
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= orders.length) return null;
    final order = orders[index];
    return DataRow2(
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        DataCell(Text('${order.itemsCount} Items')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(vertical: TSizes.xs, horizontal: TSizes.md),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status).withValues(alpha: 0.1),
            child: Text(
              order.status.name.replaceFirst(order.status.name[0], order.status.name[0].toUpperCase()),
              style: TextStyle(color: THelperFunctions.getOrderStatusColor(order.status)),
            ),
          ),
        ),
        DataCell(Text('\$${order.totalAmount}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => 0;
}
