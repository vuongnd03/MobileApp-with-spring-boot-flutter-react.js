import 'package:flutter/material.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class CustomField extends StatefulWidget {
  final String label;
  final IconData prefixcon;
  final TextInputType keyboardtype;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? initialValue;
  final int? maxLength;

  const CustomField({
    super.key,
    required this.label,
    required this.prefixcon,
    this.keyboardtype = TextInputType.text,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.maxLength,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      obscureText: widget.isPassword && _obscureText,
      keyboardType: widget.keyboardtype,
      validator: widget.validator,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      style: AppTestStyle.withColor(
        AppTestStyle.bodyMedium,
        Theme.of(context).textTheme.bodyLarge!.color!,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppTestStyle.withColor(
          AppTestStyle.bodyMedium,
          isDark ? Colors.grey[400]! : Colors.grey[600]!,
        ),
        prefixIcon: Icon(
          widget.prefixcon,
          color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
        ),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
