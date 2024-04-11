import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/models/ticket_model.dart';
import 'package:onax_app/app/routes/app_pages.dart';

class TicketListItem extends StatelessWidget {
  const TicketListItem({
    super.key,
    required this.ticket,
    required this.index,
    required this.length,
  });

  final Ticket ticket;
  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.VIEW_TICKET,
          arguments: {"id": ticket.id, "signature": ticket.signature}),
      child: ListTile(
        title: Text(
          ticket.project?.name ?? 'tickets_noProjectTitle'.tr,
          style: TextStyle(
            fontSize: textTheme.labelLarge!.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "#" + ticket.prefix.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textTheme.labelSmall!.fontSize,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
        // leading: Icon(Icons.ballot_rounded),
        subtitle: subtitle(textTheme),
        // trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ),
    );
  }

  Column subtitle(TextTheme textTheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ticket.customer.toString(),
          style: TextStyle(
            fontSize: textTheme.labelMedium!.fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          ticket.dateFormatted.toString(),
          style: TextStyle(
            fontSize: textTheme.labelMedium!.fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
