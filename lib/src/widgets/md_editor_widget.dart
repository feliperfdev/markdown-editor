import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markdown_editor/src/controllers/md_editor_controller.dart';

import '../constants/options_constant_keys.dart';

class MarkdownEditor extends StatefulWidget {
  final Color? optionsColor;
  final Function(String text) markdownText;
  const MarkdownEditor({
    super.key,
    required this.markdownText,
    this.optionsColor,
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
                  ...controller.mdOptions
                      .where((element) =>
                          (element[OptionsConstantKey.optionIcon] as String)
                              .isNotEmpty)
                      .map(
                        (type) => TextButton(
                          onPressed: () {
                            controller.onSelectOption(
                                type[OptionsConstantKey.optionType]);
                          },
                          child: SvgPicture.asset(
                            type[OptionsConstantKey.optionIcon],
                            colorFilter: ColorFilter.mode(
                              widget.optionsColor ?? Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 190,
                width: MediaQuery.sizeOf(context).width,
                child: TextFormField(
                  controller: controller.textController,
                  maxLines: 200,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  )),
                ),
              ),
            ],
          );
        });
  }
}
