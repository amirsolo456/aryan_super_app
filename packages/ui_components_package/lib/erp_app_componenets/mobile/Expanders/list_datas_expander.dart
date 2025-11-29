import 'package:flutter/material.dart';
import 'package:models_package/Data/Com/Person/dto.dart';


class PersonExpander extends StatefulWidget {
  final ResponseData person;

  const PersonExpander({super.key, required this.person});

  @override
  State<PersonExpander> createState() => _PersonExpanderState();
}

class _PersonExpanderState extends State<PersonExpander> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final person = widget.person;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              person.fullName ?? "بدون نام",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            trailing: AnimatedRotation(
              filterQuality: FilterQuality.high,
              turns: _expanded ? 0.5 : 0.0,
              duration: const Duration(milliseconds: 150),
              child: Icon(Icons.expand_more),
            ),
            style: ListTileStyle.drawer,
            onTap: () => setState(() => _expanded = !_expanded),
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            // highlightColor: Colors.transparent,
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),

            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (person.fatherName != null)
                    _infoRow("نام پدر", person.fatherName!),
                  if (person.nationalCode != null)
                    _infoRow("کد ملی", person.nationalCode!),
                  if (person.birthDate != null)
                    _infoRow("تاریخ تولد", person.birthDate!),
                  if (person.isForeign != null)
                    _infoRow("اتباع خارجی", person.isForeign! ? "بله" : "خیر"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
