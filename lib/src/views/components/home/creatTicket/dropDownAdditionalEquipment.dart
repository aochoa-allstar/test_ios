import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/ticketSteperController.dart';

class DropDownAdditionalEquipment extends StatefulWidget {
  final TicketSteperController controller;
  final String hint;
  final String validator;

  DropDownAdditionalEquipment({
    Key? key,
    required this.controller,
    required this.hint,
    required this.validator,
  }) : super(key: key);

  @override
  _DropDownAdditionalEquipmentState createState() =>
      _DropDownAdditionalEquipmentState();
}

class _DropDownAdditionalEquipmentState
    extends State<DropDownAdditionalEquipment> {
  late double h, w;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Container(
      height: h * 0.07,
      width: w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<int>(
            dropdownMaxHeight: h * 0.2,
            decoration: InputDecoration(
              label: Text('ticket_finish_additionalequip'.tr),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            iconSize: 30,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            isExpanded: true,
            hint: Center(
              child: Text(
                widget.hint,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            items: widget.controller.additionalEquipmentList.map((item) {
              return DropdownMenuItem(
                value: item.id,
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = widget.controller.additionalEquipmentIDs.contains(item.id);
                    final isSelected2 = widget.controller.additionalEquipmentIDs.contains(item.id);
                    return InkWell(
                      onTap: () {
                        isSelected ? widget.controller.additionalEquipmentIDs.remove(item.id) : widget.controller.additionalEquipmentIDs.add(item.id);
                        isSelected2 ? widget.controller.additionalEquipmentNames.remove(item.name) : widget.controller.additionalEquipmentNames.add(item.name);
                        setState(() {});
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            if (isSelected)
                              const Icon(Icons.check_box_outlined)
                            else
                              const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            value: widget.controller.additionalEquipmentIDs.isEmpty ? null : widget.controller.additionalEquipmentIDs.last,
            onChanged: (value) {
              widget.controller.setAdditionalEquipmentIDs(widget.controller.additionalEquipmentIDs);
            },
            selectedItemBuilder: (context) {
              return widget.controller.additionalEquipmentList.map(
                (item) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      widget.controller.additionalEquipmentNames.join(', '),
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ).toList();
            },
          ),
        ),
      ),
    );
  }
}
