import 'package:flutter/material.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart';

class VerticalExpansionMenu extends StatefulWidget {
  final List<ResponseData> menuItems;
  final Function(ResponseData)? onItemSelected;
  final Duration animationDuration;
  final EdgeInsets padding;
  final Color? hoverColor;
  final Color? selectedColor;

  const VerticalExpansionMenu({
    Key? key,
    required this.menuItems,
    this.onItemSelected,
    this.animationDuration = const Duration(milliseconds: 300),
    this.padding = EdgeInsets.zero,
    this.hoverColor,
    this.selectedColor,
  }) : super(key: key);

  @override
  State<VerticalExpansionMenu> createState() => _VerticalExpansionMenuState();
}

class _VerticalExpansionMenuState extends State<VerticalExpansionMenu> {
  final Map<int, bool> _expandedStates = {};
  int? _selectedMenuId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.menuItems.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(widget.menuItems[index], 0);
        },
      ),
    );
  }

  Widget _buildMenuItem(ResponseData item, int level) {
    final hasChildren = item.subMenus.isNotEmpty;
    final isExpanded = _expandedStates[item.menuId] ?? false;
    final isSelected = _selectedMenuId == item.menuId;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main menu item
        ListTile(
          contentPadding: EdgeInsets.only(
            left: 16.0 + (level * 20.0),
            right: 16.0,
          ),
          leading: item.iconUrl != null
              ? Image.network(
            item.iconUrl!,
            width: 24,
            height: 24,
            errorBuilder: (_, __, ___) =>
                Icon(_getIcon(item.icon), size: 24),
          )
              : Icon(_getIcon(item.icon), size: 24),
          title: Text(
            item.menuDesc ?? 'Unknown',
            style: TextStyle(
              fontWeight: hasChildren ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? (widget.selectedColor ?? Theme.of(context).primaryColor)
                  : null,
            ),
          ),
          trailing: hasChildren
              ? AnimatedRotation(
            turns: isExpanded ? 0.25 : 0,
            duration: widget.animationDuration,
            child: const Icon(Icons.arrow_forward_ios, size: 16),
          )
              : null,
          onTap: () {
            setState(() {
              if (hasChildren) {
                _expandedStates[item.menuId ?? 0] = !isExpanded;
              } else {
                _selectedMenuId = item.menuId;
                widget.onItemSelected?.call(item);
              }
            });
          },
          hoverColor: widget.hoverColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Submenu items with animation - FIXED VERSION
        if (hasChildren)
          AnimatedCrossFade(
            duration: widget.animationDuration,
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Container(),
            secondChild: Padding(
              padding: EdgeInsets.only(left: level * 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: item.subMenus
                    .map((subItem) => _buildMenuItem(subItem, level + 1))
                    .toList(),
              ),
            ),
          ),
      ],
    );
  }

  IconData _getIcon(String? iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'settings':
        return Icons.settings;
      case 'person':
        return Icons.person;
      default:
        return Icons.folder;
    }
  }
}