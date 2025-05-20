import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/features/admin/model/item_model.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {
  const MyContainer({
    super.key,
    required this.image,
    required this.titel,
    required this.pries,
    required this.orderTime,
    required this.orderData,
    required this.item,
    required this.onQuantityChanged,
    this.onPressed,
  });

  final String image;
  final String titel;
  final String pries;
  final String orderTime;
  final String orderData;
  final ItemsModel item;
  final Function(int) onQuantityChanged;
  final void Function()? onPressed;

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  late int quantity;
  late double itemPrice;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    quantity = widget.item.quantity;
    itemPrice = double.tryParse(widget.pries) ?? 0.0;
    updateTotalPrice();
  }

  void updateTotalPrice() {
    totalPrice = itemPrice * quantity;
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      updateTotalPrice();
      widget.onQuantityChanged(quantity);
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        updateTotalPrice();
        widget.onQuantityChanged(quantity);
      });
    }
  }

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
              widget.image,
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
                    widget.titel,
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 30 : 20,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Display unit price
                  Text(
                    "JOD سعر الوحدة :  ${widget.pries}  ",
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 16 : 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),

                  // Quantity controls
                  Row(
                    children: [
                      IconButton(
                        onPressed: decrementQuantity,
                        icon: Icon(Icons.remove, size: 18),
                        padding: EdgeInsets.all(4),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: incrementQuantity,
                        icon: Icon(Icons.add, size: 18),
                        padding: EdgeInsets.all(4),
                      ),
                      Text(": الكمية ", style: TextStyle(fontSize: 14)),
                    ],
                  ),

                  // Total price
                  Text(
                    "JOD الإجمالي : ${totalPrice.toStringAsFixed(2)} ",
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 18 : 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.orderData,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.orderTime,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: widget.onPressed,
                          icon: Icon(Icons.delete, color: AppColors.error),
                        ),
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
