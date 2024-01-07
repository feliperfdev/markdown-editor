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
    'assets/icons/header.svg',
  ),

  ///
  /// **Bold text**
  ///
  bold(
    'Bold',
    'assets/icons/bold.svg',
  ),

  ///
  /// _Italic text_
  ///
  italic(
    'Italic',
    'assets/icons/italic.svg',
  ),

  ///
  /// <u>Underlined text</u>
  ///
  underline(
    'Underline',
    'assets/icons/underline.svg',
  ),

  ///
  /// ~~text~~
  ///
  strikeThrough(
    'Strike Through',
    'assets/icons/strikethrough.svg',
  ),

  ///
  /// [link_example](https://site_link.example)
  ///
  link(
    'Link',
    'assets/icons/link.svg',
  ),

  ///
  /// ![image_example](https://image_link.example)
  ///
  image(
    'Image',
    'assets/icons/image.svg',
  ),

  ///
  /// • Bullet list item 1
  /// • Bullet list item 2
  /// • Bullet list item 3
  ///
  bullet(
    'Bullet',
    'assets/icons/bullet.svg',
  ),

  ///
  /// 1. Ordered list item 1
  /// 2. Ordered list item 2
  /// 3. Ordered list item 3
  ///
  list(
    'List',
    'assets/icons/list.svg',
  ),

  ///
  /// ```
  ///  text
  /// ```
  ///
  code(
    'Code',
    'assets/icons/code.svg',
  ),

  ///
  /// > text
  ///
  blockquote(
    'Blockquote',
    'assets/icons/blockquote.svg',
  ),

  ///
  ///
  /// ---
  ///
  ///
  separator(
    'Separator',
    'assets/icons/separator.svg',
  );

  final String name;
  final String icon;

  const MarkdownType(this.name, this.icon);
}
