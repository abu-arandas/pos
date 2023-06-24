import '/exports.dart';

class TextInputFeild extends StatelessWidget {
  final String text;
  final Widget? icon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;

  const TextInputFeild({
    super.key,
    required this.text,
    this.icon,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: white),
      decoration: InputDecoration(labelText: text, hintText: text, suffixIcon: icon),
      controller: controller,
      cursorColor: white,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: (value) {
        if (value!.isEmpty) {
          return '* required';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
