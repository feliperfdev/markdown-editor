enum MarkdownType {
  bold(
    'Bold',
    'assets/icons/bold.svg',
  ),
  italic(
    'Italic',
    'assets/icons/italic.svg',
  ),
  strikeThrough(
    'Strike Through',
    '',
  ),
  link(
    'Link',
    '',
  ),
  list(
    'List',
    '',
  ),
  bullet(
    'Bullet',
    '',
  ),
  code(
    'Code',
    '',
  ),
  blockquote(
    'Blockquote',
    '',
  ),
  separator(
    'Separator',
    '',
  ),
  header(
    'Header',
    'assets/icons/header.svg',
  );

  final String name;
  final String icon;

  const MarkdownType(this.name, this.icon);
}
