import 'package:flutter/material.dart';

//import 'package:mygold/helpers/theme/app_theme.dart';

import 'texstyle.dart';

class EditTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final double radius;
  final EdgeInsets edgeInsets;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;

  const EditTextField(
      {super.key,
      required this.hintText,
      this.isPassword = false,
      this.controller,
      this.prefixIcon,
      this.radius = 30,
      this.textInputType = TextInputType.text,
      this.edgeInsets = const EdgeInsets.fromLTRB(26, 12, 4, 12),
      this.validator});

  @override
  // ignore: library_private_types_in_public_api
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextFormField(
        controller: widget.controller,
        style: primaryTextStyle(size: 18),
        obscureText: _obscureText,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.hintText,
          contentPadding: widget.edgeInsets,
          hintText: widget.hintText,
          filled: true,
          fillColor: theme.colorScheme.surface,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide:
                BorderSide(color: theme.colorScheme.secondary, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide:
                BorderSide(color: theme.colorScheme.secondary, width: 0.0),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: theme.colorScheme.secondary,
                )
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: theme.colorScheme.secondary,
                  ),
                  onPressed: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
