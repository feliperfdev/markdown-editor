import 'package:flutter/material.dart';

import '../constants/options_constant_keys.dart';
import '../models/markdown_type.dart';

abstract class MarkdownEditorController {
  abstract final TextEditingController textController;
  abstract final List<Map<String, dynamic>> mdTypes;

  abstract final List<int> headers;
  void onSelectType(MarkdownType type);

  // Header `#` before selected text counting
  int headerCount = 0;
}

class MarkdownEditorControllerImpl implements MarkdownEditorController {
  @override
  int headerCount = 1;

  @override
  final List<int> headers = [1, 2, 3];

  @override
  final TextEditingController textController = TextEditingController();

  @override
  final List<Map<String, dynamic>> mdTypes = MarkdownType.values
      .map(
        (type) => {
          OptionsConstantKey.optionType: type,
          OptionsConstantKey.optionName: type.name,
          OptionsConstantKey.optionIcon: type.icon,
        },
      )
      .toList();

  @override
  void onSelectType(MarkdownType type) {
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
        _headerSelection(headerCount);
      case MarkdownType.italic:
        _italicSelection();
      case MarkdownType.link:
        _linkSelection();
      case MarkdownType.image:
        _imageSelection();
      case MarkdownType.list:
        _listSelection();
      case MarkdownType.separator:
        _separatorSelection();
      case MarkdownType.strikeThrough:
        _strikeThroughSelection();
      case MarkdownType.underline:
        _underlineSelection();
      case MarkdownType.checkbox:
        _checkboxBuilder(marked: false);
      default:
        textController.clear();
    }
  }

  ({int selectionEndIndex, int selectionStartIndex}) get selectionIndexes => (
        selectionStartIndex: textController.selection.start,
        selectionEndIndex: textController.selection.end,
      );

  // Initial selection cursor index on text
  int get _start => selectionIndexes.selectionStartIndex;
  // End selection cursor index on text

  int get _end => selectionIndexes.selectionEndIndex;

  // Selected text between both initial and end indexes on [TextField]
  String get _selectedText => textController.text.substring(_start, _end);

  void _boldSelection() {
    textController.text =
        textController.text.replaceRange(_start, _end, '**$_selectedText**');
  }

  void _italicSelection() {
    textController.text =
        textController.text.replaceRange(_start, _end, '_${_selectedText}_');
  }

  void _headerSelection(int h) {
    if (h >= 0 && h <= 3) {
      textController.text = textController.text.replaceRange(
        _start,
        _end,
        '${h == 0 ? "" : List.generate(h, (_) => '#').join()} $_selectedText',
      );
    }
  }

  void _linkSelection() {
    textController.text = textController.text.replaceRange(_start, _end,
        '[${_selectedText.trim().isEmpty ? "link_example" : _selectedText}](https://your_link_url.example)');
  }

  void _listSelection() {
    final splitted = _selectedText.split('\n');

    textController.text = textController.text.replaceRange(
      _start,
      _end,
      splitted.indexed.map((e) {
        final index = e.$1;
        return index != splitted.length - 1
            ? '${index + 1}. ${e.$2}\n'
            : '${index + 1}. ${e.$2}';
      }).join(),
    );
  }

  void _bulletSelection() {
    final splitted = _selectedText.split('\n');

    textController.text = textController.text.replaceRange(
      _start,
      _end,
      splitted.map((e) {
        final index = splitted.indexOf(e);
        return index != splitted.length - 1 ? '- $e\n' : '- $e';
      }).join(),
    );
  }

  void _strikeThroughSelection() {
    textController.text =
        textController.text.replaceRange(_start, _end, '~~$_selectedText~~');
  }

  void _underlineSelection() {
    textController.text =
        textController.text.replaceRange(_start, _end, '<u>$_selectedText</u>');
  }

  void _blockQuoteSelection() {
    textController.text =
        textController.text.replaceRange(_start, _end, '> $_selectedText');
  }

  void _codeSelection() {
    final lines = '\n'.allMatches(_selectedText).length + 1;

    textController.text = textController.text.replaceRange(
      _start,
      _end,
      lines == 1
          ? "```$_selectedText```"
          : '''
```
$_selectedText
```''',
    );
  }

  void _separatorSelection() {
    textController.text = textController.text.replaceRange(_start, _end, '---');
  }

  void _imageSelection() {
    textController.text = textController.text.replaceRange(_start, _end,
        '![${_selectedText.trim().isEmpty ? "image_example" : _selectedText}](https://your_image_url.example)');
  }

  void _checkboxBuilder({bool marked = false}) {
    final splitted = _selectedText.split('\n');

    textController.text = textController.text.replaceRange(
        _start,
        _end,
        splitted.indexed.map((e) {
          final index = splitted.indexOf(e.$2);
          return '- [${marked ? "x" : " "}] ${_selectedText.isEmpty ? 'Text' : e.$2}${index == splitted.length - 1 ? '' : '\n'}';
        }).join());
  }
}
