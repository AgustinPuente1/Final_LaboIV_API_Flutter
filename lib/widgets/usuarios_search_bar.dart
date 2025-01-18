import 'package:flutter/material.dart';

class UsuariosSearchBar extends StatelessWidget {
  final bool isActive;
  final TextEditingController searchController;
  final FocusNode focusNode;
  final VoidCallback onClose;
  final VoidCallback onBack;
  final ValueChanged<String> onSearch;

  const UsuariosSearchBar({
    Key? key,
    required this.isActive,
    required this.searchController,
    required this.focusNode,
    required this.onClose,
    required this.onBack,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      duration: const Duration(milliseconds: 300),
      child: (isActive)
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      focusNode: focusNode,
                      onChanged: onSearch,
                      onFieldSubmitted: onSearch,
                      decoration: const InputDecoration(hintText: 'Buscar...'),
                    ),
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.keyboard_arrow_left_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      focusNode.requestFocus();
                      onBack();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
    );
  }
}