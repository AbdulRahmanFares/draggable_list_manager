import 'package:draggable_list_manager/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditDialog extends StatefulWidget {
  final List<String> myList;
  final int index;

  const EditDialog({
    required this.myList,
    required this.index,
    super.key
  });

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {

  final obj = Constants();
  Color hintColor = Colors.black54;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the value from the myList at the specified index
    controller = TextEditingController(text: widget.myList[widget.index]);
  }  

  @override
  Widget build(BuildContext context) {

    // Device's screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // textFormField text style
    textFormFieldTextStyle(Color color) {
      return GoogleFonts.poppins(
        fontSize: screenWidth * 0.04,
        color: color,
        fontWeight: FontWeight.w500,
        letterSpacing: 2
      );
    }

    return AlertDialog(
      backgroundColor: obj.whiteShade,
      content: SizedBox(
        height: screenHeight * 0.235,
        width: screenWidth * 0.675,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.02
            ),
            Text(
              "Please enter the name",
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.04,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                letterSpacing: 1
              )
            ),
            SizedBox(
              height: screenHeight * 0.03
            ),
            
            // Name
            Container(
              height: screenHeight * 0.07,
              width: screenWidth * 0.6725,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.07)
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.07,
                  right: screenWidth * 0.07
                ),
                child: TextFormField(
                  controller: controller,
                  maxLines: 1,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.emailAddress,
                
                  // User Input Style
                  style: textFormFieldTextStyle(Colors.black54),
                  decoration: InputDecoration(
                    border: InputBorder.none, // Remove underline
                    contentPadding: const EdgeInsets.symmetric(vertical: 18), // To vertically center the hint text inside the TextFormField
                    hintText: "Name",
                    hintStyle: textFormFieldTextStyle(hintColor)
                  )
                )
              )
            ),
            SizedBox(
              height: screenHeight * 0.03
            ),
            
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // Cancel
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Close the dialog box
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: screenWidth * 0.01),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: obj.greyShade
                        )
                      )
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.035,
                        color: obj.blackShade,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1
                      )
                    )
                  )
                ),

                // Save button
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      setState(() {
                        widget.myList[widget.index] = controller.text;
                        hintColor = Colors.black54; // Reset hintColor
                      });

                      Navigator.of(context).pop(); // Close the dialog box
                    } else {
                      // Update hint color only if the input is empty
                      setState(() {
                        hintColor = Colors.red;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    fixedSize: Size(screenWidth * 0.25, screenHeight * 0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.07)
                    )
                  ),
                  child: Text(
                    "Save",
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1
                    )
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}

