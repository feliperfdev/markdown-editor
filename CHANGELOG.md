## 0.0.1

- Header still not configured

- Checkbox still not configured

- Markdown options available: Bold, italic, strikethrough, underline, code, blockquote, bullet list, ordered list, link, image

- Underline available with HTML tag </ u >

- Flexible Markdown options row

- Easy decorated editor

## 0.0.1+1

- Platforms reference

## 0.0.2

- It's possible to change editor border radius and border color
- It's possible to determine spacing between editor and Markdown options

- Some fields now are documented following Dart Docs reference

- Markdown type 'code' fix

  - Code multiline fix

- Markdown type 'header' fix
  - Multiselection for different 'Header' sizes

### 0.0.3

- Link and image using selected text when has some selection on text field

- Decoratable input text selection color and cursor color

- Checkbox markdown button added

- Ordered list markdown multiline selection fix when applied with button use

  ```
  RAW TEXT        BEFORE              NOW

  different       1. different        1. different
  repeated        2. repeated         2. repeated
  repeated        2. repeated         3. repeated
  repeated        2. repeated         4. repeated
  different_2     3. different_2      5. different_2
  ```

- `flutter_markdown` removed from dependencies

### 0.0.4

- Markdown type Checkbox checked and unchecked included in a Dropdown

- Now it's possible to inform which `MarkdownType` (option above text field) will be shown

```dart
MarkdownEditor(
  textFieldHeight: 230,
  inputBorderRadius: BorderRadius.circular(4),

  // Do not show listed types
  doNotShowTypes: const [
    MarkdownType.separator,
    MarkdownType.image,
    MarkdownType.link,
  ],
),
```
