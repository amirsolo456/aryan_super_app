import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationWidget extends StatefulWidget {
  final void Function(String) onSubmited;
  final ValueChanged<String>? onChanged;
  final int length;

  const VerificationWidget({
    super.key,
    required this.onSubmited,
    this.onChanged,
    this.length = 4,
  });

  @override
  State<VerificationWidget> createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNodes.isNotEmpty) _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String _getCode() => _controllers.map((c) => c.text).join();

  void _onChangedAt(int index, String value) {
    if (value.isNotEmpty) {
      if (value.length > 1) {
        _controllers[index].text = value.characters.first;
      }
      if (index + 1 < _focusNodes.length) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        widget.onSubmited.call(_getCode());
      }
    } else {
      if (index - 1 >= 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }

    widget.onChanged?.call(_getCode());
  }

  /// رفتار Back Button
  Future<bool> _onBackPressed() async {
    // آیا همه فیلدها خالیند؟
    bool allEmpty = _controllers.every((c) => c.text.isEmpty);

    if (allEmpty) {
      return true; // اجازه خروج بده
    }

    // پیدا کردن آخرین فیلد پُر
    for (int i = widget.length - 1; i >= 0; i--) {
      if (_controllers[i].text.isNotEmpty) {
        _controllers[i].clear();
        _focusNodes[i].requestFocus();
        widget.onChanged?.call(_getCode());
        return false; // صفحه بسته نشود
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.length, (i) {
            return SizedBox(
              height: 64,
              width: 64,
              child: TextFormField(
                controller: _controllers[i],
                focusNode: _focusNodes[i],
                onChanged: (pin) => _onChangedAt(i, pin),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                showCursor: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: "",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
