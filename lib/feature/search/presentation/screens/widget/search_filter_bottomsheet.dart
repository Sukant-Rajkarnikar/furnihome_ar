import 'package:flutter/material.dart';
import 'package:furnihome_ar/routes/route_util.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';

Widget searchFilterBottomSheet(
    BuildContext context, {
      required List<dynamic> rooms,
      required List<dynamic> categories,
      required List<int> selectedRoomIds,
      required List<int> selectedCategoryIds,
      required Function(List<int> selectedRooms, List<int> selectedCategories) onApply,
    }) {
  return SearchFilterBottomSheetWidget(
    rooms: rooms,
    categories: categories,
    selectedRoomIds: selectedRoomIds,
    selectedCategoryIds: selectedCategoryIds,
    onApply: onApply,
  );
}

class SearchFilterBottomSheetWidget extends StatefulWidget {
  final List<dynamic> rooms;
  final List<dynamic> categories;
  final List<int> selectedRoomIds;
  final List<int> selectedCategoryIds;
  final Function(List<int>, List<int>) onApply;

  const SearchFilterBottomSheetWidget({
    super.key,
    required this.rooms,
    required this.categories,
    required this.selectedRoomIds,
    required this.selectedCategoryIds,
    required this.onApply,
  });

  @override
  State<SearchFilterBottomSheetWidget> createState() =>
      _SearchFilterBottomSheetWidgetState();
}

class _SearchFilterBottomSheetWidgetState
    extends State<SearchFilterBottomSheetWidget> {
  final Color _primaryPurple = const Color(0xFF5C00E6);
  final Color _chipBackground = const Color(0xFFF5F5F5);

  late List<int> _selectedRooms;
  late List<int> _selectedCategories;

  @override
  void initState() {
    super.initState();
    _selectedRooms = List.from(widget.selectedRoomIds);
    _selectedCategories = List.from(widget.selectedCategoryIds);
  }

  void _resetAll() {
    setState(() {
      _selectedRooms.clear();
      _selectedCategories.clear();
    });
  }

  void _toggleRoom(int id) {
    setState(() {
      if (_selectedRooms.contains(id)) {
        _selectedRooms.remove(id);
      } else {
        _selectedRooms.add(id);
      }
    });
  }

  void _toggleCategory(int id) {
    setState(() {
      if (_selectedCategories.contains(id)) {
        _selectedCategories.remove(id);
      } else {
        _selectedCategories.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalSelected = _selectedRooms.length + _selectedCategories.length;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white_rbga_ffffff,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.spacing_20),
          topRight: Radius.circular(Dimens.spacing_20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: Dimens.spacing_12),
                height: Dimens.spacing_6,
                width: Dimens.spacing_64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.spacing_16),
                  color: AppColors.grey_rgba_4C4C4C.withAlpha(50),
                ),
              ),
            ),
            addVerticalSpace(Dimens.spacing_16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_16),
              child: Row(
                children: [
                  const Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  addHorizontalSpace(Dimens.spacing_12),
                  if (totalSelected > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.spacing_10,
                        vertical: Dimens.spacing_4,
                      ),
                      decoration: BoxDecoration(
                        color: _primaryPurple,
                        borderRadius: BorderRadius.circular(Dimens.spacing_16),
                      ),
                      child: Text(
                        "$totalSelected Selected",
                        style: const TextStyle(
                          color: AppColors.white_rbga_ffffff,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: _resetAll,
                    child: const Text(
                      "Reset All",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(Dimens.spacing_20),
                    child: const Padding(
                      padding: EdgeInsets.all(Dimens.spacing_8),
                      child: Icon(Icons.close_rounded, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade200, thickness: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spacing_16,
                  vertical: Dimens.spacing_8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("ROOM TYPE"),
                    addVerticalSpace(Dimens.spacing_12),
                    Wrap(
                      spacing: Dimens.spacing_8,
                      runSpacing: Dimens.spacing_12,
                      children: widget.rooms.map((room) {
                        final isSelected = _selectedRooms.contains(room.id);
                        return _buildCustomChip(
                          label: room.title,
                          isSelected: isSelected,
                          onTap: () => _toggleRoom(room.id),
                        );
                      }).toList(),
                    ),
                    addVerticalSpace(Dimens.spacing_24),
                    _buildSectionHeader("CATEGORY"),
                    addVerticalSpace(Dimens.spacing_12),
                    Wrap(
                      spacing: Dimens.spacing_8,
                      runSpacing: Dimens.spacing_12,
                      children: widget.categories.map((category) {
                        final isSelected =
                        _selectedCategories.contains(category.id);
                        return _buildCustomChip(
                          label: category.categoryName,
                          isSelected: isSelected,
                          onTap: () => _toggleCategory(category.id),
                        );
                      }).toList(),
                    ),
                    addVerticalSpace(Dimens.spacing_24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.spacing_16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_selectedRooms, _selectedCategories);
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.spacing_12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Apply Filters",
                    style: TextStyle(
                      color: AppColors.white_rbga_ffffff,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const Text(
          "Multi-select",
          style: TextStyle(
            color: Colors.black38,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.spacing_16,
          vertical: Dimens.spacing_10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? _primaryPurple : _chipBackground,
          borderRadius: BorderRadius.circular(Dimens.spacing_12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(
                Icons.check_rounded,
                color: AppColors.white_rbga_ffffff,
                size: 16,
              ),
              addHorizontalSpace(Dimens.spacing_6),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.white_rbga_ffffff : Colors.black87,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}