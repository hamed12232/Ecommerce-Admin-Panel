import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';

class SegmentButton<T> extends StatelessWidget {
  final Set<T> selected;
  final List<ButtonSegment<T>> segments;
  final void Function(Set<T>) onSelectionChanged;

  const SegmentButton({
    super.key,
    required this.selected,
    required this.segments,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      segments: segments,
      selected: selected,
      onSelectionChanged: onSelectionChanged,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TColors.primary;
          }
          return null;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return null;
        }),
      ),
    );
  }
}
