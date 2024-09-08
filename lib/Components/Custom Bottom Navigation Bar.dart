import 'package:flutter/material.dart';
import 'package:to_to_app/App%20Cubit/Cubit.dart';
import 'package:to_to_app/Constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

    double displayWidth = MediaQuery.of(context).size.width;
    TodoCubit cubit = TodoCubit.get(context);
    List<IconData> listOfIcons = [
      Icons.menu,
      Icons.task_alt_sharp,
      Icons.archive_outlined
    ];


    return Container(
      margin: EdgeInsets.all(displayWidth * .01),
      height: displayWidth * .170,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            cubit.changeIndexBottomNav(index);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == cubit.currentIndex
                      ? displayWidth * .42
                      : displayWidth * .21,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == cubit.currentIndex
                        ? displayWidth * .12
                        : 0,
                    width: index == cubit.currentIndex
                        ? displayWidth * .40
                        : 0,
                    decoration: BoxDecoration(
                      color: index == cubit.currentIndex
                          ? Colors.white.withOpacity(.7)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == cubit.currentIndex
                      ? displayWidth * .40
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == cubit.currentIndex
                                ? displayWidth * .12
                                : 0,
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              opacity:
                              index == cubit.currentIndex ? 1 : 0,
                              duration: Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Text(
                                index == cubit.currentIndex
                                    ? '${cubit.titles[index]}'
                                    : '',
                                style: TextStyle(
                                    color: defaultColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                    fontFamily: defaultFont),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == cubit.currentIndex
                                ? displayWidth * .03
                                : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .077,
                            color: index == cubit.currentIndex
                                ? defaultColor
                                : Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
