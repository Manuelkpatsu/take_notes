import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  /// Shows a snackbar
  static void showSnackbar(BuildContext context, String text) {
    final snackbar = SnackBar(
      content: Text(text, style: TextStyle(color: Colors.white)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  /// Shows modal bottomSheet
  static void showModalSheet(
    BuildContext context,
    String title,
    VoidCallback onPressed,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: Colors.black, width: 2),
                            ),
                            onPrimary: Colors.black,
                            primary: Colors.white,
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 45,
                        child: TextButton(
                          child: Text('Yes'),
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            onPrimary: Colors.white,
                            primary: Colors.black,
                            elevation: 0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static String formatDateTime(String dateTime) {
    var formatter = new DateFormat('MMM dd, yyyy');
    var formatter2 = new DateFormat('hh:mm a');
    DateTime dt = DateTime.parse(dateTime);
    if (dt.day == DateTime.now().day)
      return formatter2.format(dt);
    else
      return formatter.format(dt);
  }

  static String getInitials(String username) {
    List<String> names = username.split(" ");
    String initials = "";

    // Return an empty string if username is null
    if (username.isEmpty) return username;

    // Take first character if string is a single word
    if (names.length == 1) return username.characters.first;

    if (names.length >= 2) {
      for (var i = 0; i < 2; i++) {
        initials += '${names[i][0]}';
      }

      return initials;
    }

    return initials;
  }

  static void showColorPallete({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Container(
            height: 100,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
