import 'package:draggable_list_manager/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDraggableList extends StatefulWidget {
  const MyDraggableList({super.key});

  @override
  State<MyDraggableList> createState() => _MyDraggableListState();
}

class _MyDraggableListState extends State<MyDraggableList> {

  final obj = Constants();
  List<String> myList = [
    "Fares Rahman",
    "Bala",
    "Esakkimuthu",
    "Sijo",
    "Hacker",
    "Shakthi",
    "Senthil",
    "Prakash",
    "Suriya",
    "Manoj Kumar",
    "Prasath Buddy",
    "Raja"
  ];
  int? draggedItemIndex; // Store the index of the dragged item

  @override
  Widget build(BuildContext context) {

    // Device's screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Function to show edit dialog
    void showEditDialog(int index, String data) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController controller = TextEditingController(text: myList[index]);

          return AlertDialog(
            backgroundColor: obj.whiteShade,
            content: SizedBox(
              height: screenHeight * 0.3,
              width: screenWidth * 0.675,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02
                  ),
                  Text(
                    "Please enter the name",
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.04,
                      color: Colors.black54,
                      letterSpacing: 1
                    )
                  )
                ]
              )
            )
          );
        }
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: obj.whiteShade,
        appBar: AppBar(
          backgroundColor: obj.darkBlue,
          toolbarHeight: screenHeight * 0.07,
          title: Text(
            "DRAGGABLE LIST",
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 3
            )
          ),
          centerTitle: true
        ),
        body: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.02
            ),
            Center(
              child: SizedBox(
                height: screenHeight * 0.73,
                width: screenWidth * 0.8,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    
                    // Dragging container
                    return LongPressDraggable<String>(
                      data: myList[index],
                      feedback: Material(
                        elevation: 0.0,
                        child: Container(
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                            color: obj.whiteShade,
                            borderRadius: BorderRadius.circular(screenWidth * 0.07)
                          ),
                          child: Center(
                            child: Text(
                              myList[index],
                              style: TextStyle(
                                fontSize: screenWidth * 0.037,
                                color: obj.greyShade,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2
                              )
                            )
                          )
                        )
                      ),
                      childWhenDragging: Container(),
                      onDragStarted: () {
                        // Set the index of the dragged item when drag starts
                        setState(() {
                          draggedItemIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: screenWidth * 0.03),
                        height: screenHeight * 0.07,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.07)
                        ),
                        child: Center(
                          child: Text(
                            myList[index],
                            style: TextStyle(
                              fontSize: screenWidth * 0.037,
                              color: obj.greyShade,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2
                            )
                          )
                        )
                      )
                    );
                  }
                )
              )
            )
          ]
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(
            top: screenHeight * 0.02,
            bottom: screenHeight * 0.02
          ),
          height: screenHeight * 0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // Edit option
              DragTarget<String>(
                onWillAccept: (data) {
                  // Allow accepting only if the dragged item is over the edit container
                  return data != null;
                },
                onAccept: (data) {
                  // Show the edit dialog when item is dragged to edit container
                  showEditDialog(draggedItemIndex!, data);
                  
                  // Reset the dragged item index after processing
                  setState(() {
                    draggedItemIndex = null;
                  });
                },
                builder: (context, employeeData, rejectedData) {
                  return Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.1),
                    height: screenWidth * 0.17,
                    width: screenWidth * 0.17,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.15)
                    ),
                    child: Icon(
                      Icons.edit_sharp,
                      color: obj.greyShade,
                      size: screenWidth * 0.07
                    )
                  );
                }
              ),

              // Delete option
              DragTarget<String>(
                onWillAccept: (data) {
                  // Allow accepting only if the dragged item is over the delete container
                  return data != null;
                },
                onAccept: (data) {
                  // Remove the container from the list
                  setState(() {
                    myList.remove(data);
                  });
                },
                builder: (context, employeeData, rejectedData) {
                  return Container(
                    margin: EdgeInsets.only(right: screenWidth * 0.1),
                    height: screenWidth * 0.17,
                    width: screenWidth * 0.17,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.15)
                    ),
                    child: Icon(
                      CupertinoIcons.delete_solid,
                      color: Colors.red,
                      size: screenWidth * 0.07
                    ) 
                  );
                }
              )
            ]
          )
        )
      )
    );
  }
}

