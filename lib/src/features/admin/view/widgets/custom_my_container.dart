import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:flutter/material.dart';

class CustomMyContainer extends StatelessWidget {
  const CustomMyContainer({
    super.key,
    required this.image,
    required this.titel,
    required this.description,
    required this.quintity,
    this.onPressedelet,
  });

  final String image;
  final String titel;
  final String description;
  final String quintity;
  final void Function()? onPressedelet;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Image.network(
              image,
              width: screenWidth * 0.3,
              height: screenWidth * 0.28,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    titel,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 30 : 20,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: screenWidth > 600 ? 20 : 16,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "JOD  $quintity",
                        style: TextStyle(
                          fontSize: screenWidth > 600 ? 20 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: onPressedelet,
                        icon: Icon(Icons.delete, color: AppColors.error),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
