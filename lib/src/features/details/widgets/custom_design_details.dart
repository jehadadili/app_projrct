import 'package:bazaro_cs/src/core/style/color.dart';
import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomDesignDetails extends StatefulWidget {
  final String image;
  final String description;
  final String title;
  final String quintity;
  final Function(int quantity) onAddToCart;

  const CustomDesignDetails({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.quintity,
    required this.onAddToCart,
  });

  @override
  State<CustomDesignDetails> createState() => _CustomDesignDetailsState();
}

class _CustomDesignDetailsState extends State<CustomDesignDetails> {
  int quantity = 1; // Start with quantity 1
  late double itemPrice; // Price per unit

  @override
  void initState() {
    super.initState();
    // Parse the price from quintity
    itemPrice = double.tryParse(widget.quintity) ?? 0.0;
  }

  // Calculate total price
  double get totalPrice => itemPrice * quantity;

  // Increase quantity
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  // Decrease quantity but not below 1
  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: widget.image,
              width: MediaQuery.of(context).size.width,
              height: 300,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Quantity",
                        style: TextStyle(
                          color: AppColors.blackText,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 120),
                      Expanded(
                        child: Text(
                          "${totalPrice.toStringAsFixed(2)} JOD", // Display total price
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: decrementQuantity,
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: incrementQuantity, 
                        icon: const Icon(Icons.add)
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SubmitButton(
                    text: "Add to Cart", 
                    onPressed: () => widget.onAddToCart(quantity),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}