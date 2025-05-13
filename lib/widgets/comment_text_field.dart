import 'package:skintelligent/commons.dart';
import 'package:skintelligent/cubit/make_review_cubit/make_review_cubit.dart';

class commentTextField extends StatelessWidget {
  const commentTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Comment',
        border: OutlineInputBorder(),
      ),
      maxLines: 2,
      minLines: 1,
      maxLength: 100, // Limit to ~5 lines
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required int? maxLength,
        required bool isFocused,
      }) {
        final remaining = (maxLength ?? 0) - currentLength;
        return Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'المتبقي: $remaining حرف',
            style: TextStyle(
              fontSize: 12,
              color: remaining < 25 ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}