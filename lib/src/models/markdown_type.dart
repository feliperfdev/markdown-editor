enum MarkdownType {
  header(
    'Header',
    'assets/icons/header.svg',
  ),
  bold(
    'Bold',
    'assets/icons/bold.svg',
  ),
  italic(
    'Italic',
    'assets/icons/italic.svg',
  ),
  underline(
    'Underline',
    'assets/icons/underline.svg',
  ),
  strikeThrough(
    'Strike Through',
    'assets/icons/strikethrough.svg',
  ),
  link(
    'Link',
    '',
  ),
  bullet(
    'Bullet',
    'assets/icons/bullet.svg',
  ),
  list(
    'List',
    'assets/icons/list.svg',
  ),
  code(
    'Code',
    'assets/icons/code.svg',
  ),
  blockquote(
    'Blockquote',
    '',
  ),
  separator(
    'Separator',
    '',
  );

  final String name;
  final String icon;

  const MarkdownType(this.name, this.icon);
}
