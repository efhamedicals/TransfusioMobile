import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:transfusio/src/core/services/service_locator.dart';
import 'package:transfusio/src/core/themes/colors/app_colors.dart';
import 'package:transfusio/src/shared/presentation/view_models/theme_view_model.dart';

class CustomSearchField extends StatelessWidget {
  final String _initialValue;
  final String _hintText;
  final List<String> _items;
  final Function(String value) _onChanged;

  const CustomSearchField({
    required String initialValue,
    required String hintText,
    required List<String> items,
    required Function(String value) onChanged,
    super.key,
  }) : _initialValue = initialValue,
       _hintText = hintText,
       _items = items,
       _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: (f, cs) => _items,
      selectedItem: _initialValue,
      onChanged: (value) {
        _onChanged(value!);
      },
      decoratorProps: DropDownDecoratorProps(
        baseStyle: TextStyle(
          color:
              (locator<ThemeViewModel>().isDarkModeOn)
                  ? Colors.white
                  : Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: AppColors.placeholderBg,
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        title: Padding(
          padding: const EdgeInsets.all(4.0).copyWith(top: 8),
          child: Text(
            _hintText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ),
        constraints: const BoxConstraints.tightFor(width: 300, height: 300),
      ),
    );
  }
}
