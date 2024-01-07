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

    test('- Header 1 (#)', () {
      final textController = controller.textController;
      textController.text = 'flutter';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.headerCount = 1;
      controller.onSelectType(MarkdownType.header);
      expect(textController.text, '# flutter');
    });

    test('- Header 2 (##)', () {
      final textController = controller.textController;
      textController.text = 'flutter';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.headerCount = 2;
      controller.onSelectType(MarkdownType.header);
      expect(textController.text, '## flutter');
    });

    test('- Header 3 (###)', () {
      final textController = controller.textController;
      textController.text = 'flutter';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.headerCount = 3;
      controller.onSelectType(MarkdownType.header);
      expect(textController.text, '### flutter');
    });

    test('- Bold', () {
      final textController = controller.textController;
      textController.text = 'flutter';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.onSelectType(MarkdownType.bold);
      expect(textController.text, '**flutter**');
    });

    test('- Italic', () {
      final textController = controller.textController;
      textController.text = 'flutterweb';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.onSelectType(MarkdownType.italic);
      expect(textController.text, '_flutterweb_');
    });

    test('- Code', () {
      final textController = controller.textController;
      textController.text = 'widget';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length,
      );
      controller.onSelectType(MarkdownType.code);
      expect(textController.text, "```widget```");
    });

    test('- Code | Multiline', () {
      final textController = controller.textController;
      textController.text = '''
text1
text2
text3
''';
      textController.selection = textController.selection.copyWith(
        baseOffset: 0,
        extentOffset: textController.text.length - 1,
      );
      controller.onSelectType(MarkdownType.code);
      expect(textController.text, '''
```
text1
text2
text3
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
      controller.onSelectType(MarkdownType.blockquote);
      expect(textController.text, '> flutter is the future');
    });

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
      controller.onSelectType(MarkdownType.bullet);
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
      controller.onSelectType(MarkdownType.list);
      expect(textController.text, '''
1. One
2. Two
3. Three
4. Four
''');
    });
  });
}
