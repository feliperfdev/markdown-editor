import 'package:flutter_test/flutter_test.dart';
import 'package:markdown_editor_mobile_web/src/controllers/md_editor_controller.dart';
import 'package:markdown_editor_mobile_web/src/models/markdown_type.dart';

void main() {
  group('Check if Markdown type is correctly applied on text selection', () {
    late MarkdownEditorController controller;
    setUpAll(
      () {
        controller = MarkdownEditorControllerImpl();
      },
    );

    test('- Bold', () {
      final textController = controller.textController;
      textController.text = 'flutter';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.onSelectOption(MarkdownType.bold);
      expect(textController.text, '**flutter**');
    });

    test('- Italic', () {
      final textController = controller.textController;
      textController.text = 'flutterweb';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.onSelectOption(MarkdownType.italic);
      expect(textController.text, '_flutterweb_');
    });

    test('- Code', () {
      final textController = controller.textController;
      textController.text = 'widget';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.onSelectOption(MarkdownType.code);
      expect(textController.text, '''
```
widget
```
''');
    });

    test('- Blockquote', () {
      final textController = controller.textController;
      textController.text = 'flutter is the future';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.onSelectOption(MarkdownType.blockquote);
      expect(textController.text, '> flutter is the future');
    });

    // test('- Blockquote (semi selection)', () {
    //   final textController = controller.textController;
    //   textController.text = 'flutter is the future';
    //   textController.selection = textController.selection.copyWith(
    //     baseOffset: 8,
    //     extentOffset: textController.text.length,
    //   );
    //   controller.onSelectOption(MarkdownType.blockquote);
    //   expect(textController.text, '> flutter is the future');
    // });

    test('- Bullet', () {
      final textController = controller.textController;
      textController.text = '''
One
Two
Three
Four
''';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length - 1,
      );
      controller.onSelectOption(MarkdownType.bullet);
      expect(textController.text, '''
- One
- Two
- Three
- Four
''');
    });

    test('- List', () {
      final textController = controller.textController;
      textController.text = '''
One
Two
Three
Four
''';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length - 1,
      );
      controller.onSelectOption(MarkdownType.list);
      expect(textController.text, '''
1. One
2. Two
3. Three
4. Four
''');
    });
  });
}
