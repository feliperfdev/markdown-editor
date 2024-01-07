import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markdown_editor_mobile_web/src/controllers/md_editor_controller.dart';

import '../constants/options_constant_keys.dart';

class MarkdownEditor extends StatefulWidget {
  final Color? optionsColor;
  final Function(String text) markdownText;
  final bool? showTooltip;
  final double? textFieldHeight;
  final int? textFieldMaxLines;
  const MarkdownEditor({
    super.key,
    required this.markdownText,
    this.optionsColor = Colors.black,
    this.showTooltip = true,
    this.textFieldHeight = 190,
    this.textFieldMaxLines = 200,
  });

  @override
  State<MarkdownEditor> createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  final controller = MarkdownEditorControllerImpl();

  @override
  void initState() {
    controller.textController.addListener(() {
      widget.markdownText(controller.textController.text);
    });
    super.initState();
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
                  ...controller.mdOptions.map(
                    (type) => Tooltip(
                      decoration:
                          widget.showTooltip! ? null : const BoxDecoration(),
                      message: type[OptionsConstantKey.optionName],
                      child: TextButton(
                        onPressed: () {
                          controller.onSelectOption(
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
              const SizedBox(height: 8),
              SizedBox(
                height: widget.textFieldHeight,
                width: MediaQuery.sizeOf(context).width,
                child: TextFormField(
                  controller: controller.textController,
                  maxLines: widget.textFieldMaxLines,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: Colors.black,
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
