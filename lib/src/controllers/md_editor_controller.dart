import 'package:flutter/material.dart';

import '../constants/options_constant_keys.dart';
import '../models/markdown_type.dart';

abstract class MarkdownEditorController {
  abstract final TextEditingController textController;
  abstract final List<Map<String, dynamic>> mdOptions;
  void onSelectOption(MarkdownType type);

  ({int selectionStartIndex, int selectionEndIndex}) get selectionIndexes;
}

class MarkdownEditorControllerImpl implements MarkdownEditorController {
  @override
  final TextEditingController textController = TextEditingController();

  @override
  final List<Map<String, dynamic>> mdOptions = MarkdownType.values
      .map(
        (type) => {
          OptionsConstantKey.optionType: type,
          OptionsConstantKey.optionName: type.name,
          OptionsConstantKey.optionIcon: type.icon,
        },
      )
      .toList();

  @override
  void onSelectOption(MarkdownType type) {
    switch (type) {
      case MarkdownType.bold:
        _boldSelection();
      case MarkdownType.blockquote:
        _blockQuoteSelection();
      case MarkdownType.bullet:
        _bulletSelection();
      case MarkdownType.code:
        _codeSelection();
      case MarkdownType.header:
        _headerSelection();
      case MarkdownType.italic:
        _italicSelection();
      case MarkdownType.link:
        _linkSelection();
      case MarkdownType.list:
        _listSelection();
      case MarkdownType.separator:
        _separatorSelection();
      case MarkdownType.strikeThrough:
        _strikeThroughSelection();
      case MarkdownType.underline:
        _underlineSelection();
      default:
        textController.clear();
    }
  }

  void _boldSelection() {
    final start = textController.selection.start;
    final end = textController.selection.end;
    final textSelected = textController.text.substring(start, end);
    textController.text =
        textController.text.replaceRange(start, end, '**$textSelected**');
  }

  void _italicSelection() {
    final start = selectionIndexes.selectionStartIndex;
    final end = selectionIndexes.selectionEndIndex;
    final textSelected = textController.text.substring(start, end);
    textController.text =
        textController.text.replaceRange(start, end, '_${textSelected}_');
  }

  void _headerSelection() {}
  void _linkSelection() {}
  void _listSelection() {
    final start = selectionIndexes.selectionStartIndex;
    final end = selectionIndexes.selectionEndIndex;
    final textSelected = textController.text.substring(start, end);

    final splitted = textSelected.split('\n');

    textController.text = textController.text.replaceRange(
      start,
      end,
      splitted.map((e) {
        final index = splitted.indexOf(e);
        return index != splitted.length - 1
            ? '${index + 1}. $e\n'
            : '${index + 1}. $e';
      }).join(),
    );
  }

  void _bulletSelection() {
    final start = selectionIndexes.selectionStartIndex;
    final end = selectionIndexes.selectionEndIndex;
    final textSelected = textController.text.substring(start, end);

    final splitted = textSelected.split('\n');

    textController.text = textController.text.replaceRange(
      start,
      end,
      splitted.map((e) {
        final index = splitted.indexOf(e);
        return index != splitted.length - 1 ? '- $e\n' : '- $e';
      }).join(),
    );
  }

  void _strikeThroughSelection() {
    final start = selectionIndexes.selectionStartIndex;
    final end = selectionIndexes.selectionEndIndex;
    final textSelected = textController.text.substring(start, end);
    textController.text =
        textController.text.replaceRange(start, end, '~~$textSelected~~');
  }

  void _underlineSelection() {
    final start = selectionIndexes.selectionStartIndex;
    final end = selectionIndexes.selectionEndIndex;
    final textSelected = textController.text.substring(start, end);
    textController.text =
        textController.text.replaceRange(start, end, '<u>$textSelected</u>');
  }

  void _blockQuoteSelection() {
    final start = selectionIndexes.selectionStartIndex;
    final end = selectionIndexes.selectionEndIndex;
    final textSelected = textController.text.substring(start, end);

    textController.text =
        textController.text.replaceRange(start, end, '> $textSelected');
  }

  void _codeSelection() {
    final start = selectionIndexes.selectionStartIndex;
    final end = selectionIndexes.selectionEndIndex;
    final textSelected = textController.text.substring(start, end);
    textController.text = '''
```
$textSelected
```
''';
  }

  void _separatorSelection() {}

  @override
  ({int selectionEndIndex, int selectionStartIndex}) get selectionIndexes => (
        selectionStartIndex: textController.selection.start,
        selectionEndIndex: textController.selection.end,
      );
}
