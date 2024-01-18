import '../constants/markdown_svg.dart';

enum MarkdownType {
  ///
  /// ##### Title
  /// #### Title
  /// ### Title
  /// ## Title
  /// # Title
  ///
  header(
    'Header',
    MarkdownSvg.header,
  ),

  ///
  /// **Bold text**
  ///
  bold(
    'Bold',
    MarkdownSvg.bold,
  ),

  ///
  /// _Italic text_
  ///
  italic(
    'Italic',
    MarkdownSvg.italic,
  ),

  ///
  /// <u>Underlined text</u>
  ///
  underline(
    'Underline',
    MarkdownSvg.underline,
  ),

  ///
  /// ~~text~~
  ///
  strikeThrough(
    'Strike Through',
    MarkdownSvg.strikethrough,
  ),

  ///
  /// [link_example](https://site_link.example)
  ///
  link(
    'Link',
    MarkdownSvg.link,
  ),

  ///
  /// ![image_example](https://image_link.example)
  ///
  image(
    'Image',
    MarkdownSvg.image,
  ),

  ///
  /// • Bullet list item 1
  /// • Bullet list item 2
  /// • Bullet list item 3
  ///
  bullet(
    'Bullet',
    MarkdownSvg.bullet,
  ),

  ///
  /// 1. Ordered list item 1
  /// 2. Ordered list item 2
  /// 3. Ordered list item 3
  ///
  list(
    'List',
    MarkdownSvg.list,
  ),

  ///
  /// ```
  ///  text
  /// ```
  ///
  code(
    'Code',
    MarkdownSvg.code,
  ),

  ///
  /// > text
  ///
  blockquote(
    'Blockquote',
    MarkdownSvg.blockquote,
  ),

  ///
  ///
  /// ---
  ///
  ///
  separator(
    'Separator',
    MarkdownSvg.separator,
  ),

  ///
  ///
  /// `- [ ] Text`
  ///
  /// `- [x] Text`
  ///
  ///
  checkbox(
    'Checkbox',
    MarkdownSvg.checkbox,
  );

  final String name;
  final String icon;

  const MarkdownType(this.name, this.icon);
}
