import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markdown_editor_mobile_web/src/controllers/md_editor_controller.dart';

import '../constants/options_constant_keys.dart';
import '../models/markdown_type.dart';

class MarkdownEditor extends StatefulWidget {
  /// Returns raw markdown text at `text` String while being typed
  final Function(String text) markdownText;

  /// Changes color of the Markdown options in the top of
  /// editor.
  ///
  /// Default value is [Colors.black]
  final Color? optionsColor;

  /// If true, enable [Tooltip] view while moving mouse
  /// pointer over markdown options
  ///
  /// Default value is `true`
  final bool? showTooltip;

  /// Determines [TextFormField] height
  ///
  /// Default value is `190`
  final double? textFieldHeight;

  /// Determines [TextFormField] max lines
  ///
  /// Default value is `200`
  final int? textFieldMaxLines;

  /// Determines [TextFormField] BorderRadius
  ///
  /// Default value is [BorderRadius.circular(4)]
  final BorderRadius? inputBorderRadius;

  /// Determines [TextFormField] border color
  ///
  /// Default value is [Colors.black]
  final Color? inputBorderColor;

  /// Determines spacing between editor and Markdown options
  ///
  /// Default value is `8`
  final double? optionsSpacingFromEditor;

  const MarkdownEditor({
    super.key,
    required this.markdownText,
    this.optionsColor = Colors.black,
    this.showTooltip = true,
    this.textFieldHeight = 190,
    this.textFieldMaxLines = 200,
    this.inputBorderRadius,
    this.inputBorderColor = Colors.black,
    this.optionsSpacingFromEditor = 8,
  });

  @override
  State<MarkdownEditor> createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  final controller = MarkdownEditorControllerImpl();

  /// Will trigger on Widget initState to update the raw
  /// Markdown text while being typed at the [TextFormField]
  ///
  /// On initState, this procedure is added as [TextEditingController]
  /// listener, then is removed on dispose.
  void _setMarkdownText() =>
      widget.markdownText(controller.textController.text);

  @override
  void initState() {
    controller.textController.addListener(_setMarkdownText);
    super.initState();
  }

  @override
  void dispose() {
    controller.textController.removeListener(_setMarkdownText);
    controller.textController.clear();
    controller.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.textController,
        builder: (context, value, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  ...controller.mdTypes.map(
                    (type) => Tooltip(
                      decoration:
                          widget.showTooltip! ? null : const BoxDecoration(),
                      message: type[OptionsConstantKey.optionName],
                      child: type[OptionsConstantKey.optionType] ==
                              MarkdownType.header
                          ? _MarkdownHeaderButtonWidget(
                              headers: controller.headers,
                              optionIcon: type[OptionsConstantKey.optionIcon],
                              optionColor: widget.optionsColor,
                              onSelectHeader: (h) {
                                controller.headerCount = h;
                                controller.onSelectType(MarkdownType.header);
                              },
                            )
                          : TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () {
                                controller.onSelectType(
                                    type[OptionsConstantKey.optionType]);
                              },
                              child: SvgPicture.asset(
                                type[OptionsConstantKey.optionIcon],
                                colorFilter: ColorFilter.mode(
                                  widget.optionsColor!,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                    ),
                  )
                ],
              ),
              SizedBox(height: widget.optionsSpacingFromEditor),
              SizedBox(
                height: widget.textFieldHeight,
                width: MediaQuery.sizeOf(context).width,
                child: TextFormField(
                  controller: controller.textController,
                  maxLines: widget.textFieldMaxLines,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          widget.inputBorderRadius ?? BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: widget.inputBorderColor ?? Colors.black,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

/// Custom Markdown type Header Widget defined to be a
/// [DropdownButton] for more then one kind of header type selection
class _MarkdownHeaderButtonWidget extends StatelessWidget {
  /// Header options list
  ///
  /// # Header (Header 1 - #)
  /// ## Header (Header 2 - ##)
  /// ### Header (Header 3 - ###)
  final List<String> headers;

  /// Header option icon (already defined at [MarkdownType] enum)
  final String optionIcon;

  /// Header option color
  ///
  /// Default value is [Colors.black]
  final Color? optionColor;

  /// Header `#` counting added to text based on `h` parsed value
  final Function(int h) onSelectHeader;

  const _MarkdownHeaderButtonWidget({
    required this.headers,
    required this.optionIcon,
    required this.optionColor,
    required this.onSelectHeader,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Theme(
        data: Theme.of(context).copyWith(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: DropdownButton<String>(
          underline: const SizedBox.shrink(),
          value: headers.first,
          items: headers.map(
            (header) {
              final index = headers.indexOf(header);
              return DropdownMenuItem(
                value: header,
                child: SvgPicture.asset(
                  optionIcon,
                  height: 32 - (index * 5),
                  colorFilter: ColorFilter.mode(
                    optionColor!,
                    BlendMode.srcIn,
                  ),
                ),
              );
            },
          ).toList(),
          onChanged: (value) {
            onSelectHeader(int.parse(value!.split(' ').last));
          },
        ),
      ),
    );
  }
}
