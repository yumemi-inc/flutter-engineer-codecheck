import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required TextEditingController textEditingController,
    required void Function(String)? onChanged,
    required void Function(String)? onSubmitted,
  })  : _textEditingController = textEditingController,
        _onChanged = onChanged,
        _onSubmitted = onSubmitted;

  final TextEditingController _textEditingController;
  final void Function(String)? _onChanged;
  final void Function(String)? _onSubmitted;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SearchBar(
        elevation: const MaterialStatePropertyAll(0), // appbarと同じ高さに
        controller: _textEditingController,
        backgroundColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.1)),
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.search),
        ),
        trailing: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _textEditingController.clear,
          ),
        ],
        onChanged: _onChanged,
        onSubmitted: _onSubmitted,
      ),
    );
  }
}
