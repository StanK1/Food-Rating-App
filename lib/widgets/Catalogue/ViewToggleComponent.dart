import 'package:flutter/material.dart';

class ViewToggleComponent extends StatefulWidget {
  final Function(bool) onViewChange;
  final bool isGridView;

  const ViewToggleComponent({
    Key? key,
    this.onViewChange = _defaultOnViewChange,
    this.isGridView = true,
  }) : super(key: key);

  static void _defaultOnViewChange(bool value) {}

  @override
  _ViewToggleComponentState createState() => _ViewToggleComponentState();
}

class _ViewToggleComponentState extends State<ViewToggleComponent> {
  late bool _isGridView;

  @override
  void initState() {
    super.initState();
    _isGridView = widget.isGridView;
  }

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
      widget.onViewChange(_isGridView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFF05032A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildToggleButton(
            isActive: _isGridView,
            icon: Icons.grid_view,
          ),
          _buildToggleButton(
            isActive: !_isGridView,
            icon: Icons.view_list,
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required bool isActive,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: _toggleView,
      child: Container(
        width: 35,
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF7714AE) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

