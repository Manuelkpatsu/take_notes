import 'package:flutter/material.dart';
import 'package:takenotes/utils/helper.dart';

class NoteGrid extends StatelessWidget {
  final String title;
  final String content;
  final String updatedAt;
  final VoidCallback onPressed;
  final Color color;

  NoteGrid({
    required this.title,
    required this.content,
    required this.updatedAt,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Card(
        color: color,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: title.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      content,
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.centerRight,
                  child: Text(
                    Helper.formatDateTime(updatedAt),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
