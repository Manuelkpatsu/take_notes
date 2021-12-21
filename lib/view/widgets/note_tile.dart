import 'package:flutter/material.dart';
import 'package:takenotes/core/models/note.dart';
import 'package:takenotes/utils/helper.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onPressed;
  final Color color;

  NoteTile({
    required this.note,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 5, right: 5, top: 10),
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  note.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  note.content!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.centerRight,
                child: Text(
                  Helper.formatDateTime(note.updatedAt!),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
