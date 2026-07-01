import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/shared/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomSearchFilterBar extends StatefulWidget {
  final String hintText;
  final String? initialSearchQuery;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String>? onSearchSubmitted;
  final VoidCallback? onFilterTap;
  final VoidCallback? onDateTap;
  final Map<String, VoidCallback>? activeFilters;
  final EdgeInsetsGeometry? padding;

  const CustomSearchFilterBar({
    super.key,
    required this.hintText,
    this.initialSearchQuery,
    required this.onSearchChanged,
    this.onSearchSubmitted,
    this.onFilterTap,
    this.onDateTap,
    this.activeFilters,
    this.padding,
  });

  @override
  State<CustomSearchFilterBar> createState() => _CustomSearchFilterBarState();
}

class _CustomSearchFilterBarState extends State<CustomSearchFilterBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialSearchQuery);
  }

  @override
  void didUpdateWidget(covariant CustomSearchFilterBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSearchQuery != oldWidget.initialSearchQuery &&
        widget.initialSearchQuery != _controller.text) {
      _controller.text = widget.initialSearchQuery ?? "";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters = widget.activeFilters != null && widget.activeFilters!.isNotEmpty;

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    controller: _controller,
                    onChanged: widget.onSearchChanged,
                    onSubmitted: (v) {
                      if (widget.onSearchSubmitted != null) {
                        widget.onSearchSubmitted!(v);
                      } else {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: const Color(0xFF94A3B8),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFF64748B),
                        size: 22,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ),
              if (widget.onFilterTap != null) ...[
                SizedBox(width: 3.w),
                _buildFilterIcon(
                  Icons.filter_list_rounded,
                  widget.onFilterTap!,
                ),
              ],
              if (widget.onDateTap != null) ...[
                SizedBox(width: 3.w),
                _buildFilterIcon(
                  Icons.date_range_rounded,
                  widget.onDateTap!,
                ),
              ],
            ],
          ),
          if (hasActiveFilters)
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Row(
                children: widget.activeFilters!.entries.map((entry) {
                  return _buildActiveFilterChip(entry.key, entry.value);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 6.h,
        width: 6.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, color: const Color(0xFF475569), size: 22),
      ),
    );
  }

  Widget _buildActiveFilterChip(String label, VoidCallback onDelete) {
    return Container(
      margin: EdgeInsets.only(right: 2.w),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF3B82F6),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 1.w),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              Icons.close_rounded,
              size: 16,
              color: Color(0xFF3B82F6),
            ),
          ),
        ],
      ),
    );
  }
}
