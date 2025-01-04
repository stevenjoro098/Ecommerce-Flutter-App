import 'package:entry/entry.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderCode;
  final String name;
  final String email;
  final String created;
  final String total;
  final bool paid;
  OrderCard({super.key,
    required this.orderCode,
    required this.name,
    required this.email,
    required this.created,
    required this.total,
    required this.paid
  });

  @override
  Widget build(BuildContext context) {
    return Entry.all(
      duration: const Duration(seconds: 1),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Order Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),),
              Text('Order Number: ${orderCode}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
              Text("Name: ${name}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.grey),),
              email.isNotEmpty ? Text(email, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),) : const Text('No Email'),
              Text("Order Date: ${created}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text("Total: ${total}",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              const SizedBox(height: 10,),
              (paid)
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                        child: Text('Paid', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),),
                      ),
                      )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                            child: Text('Not Paid', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            hintText: 'Enter Phone Number',
                            labelText: 'Enter Phone Number',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20), // Circular corners with a 30px radius
                              borderSide: BorderSide.none, // Removes the border line
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey), // Border when the field is not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.blue), // Border when the field is focused
                        ),
                      ),
                        ),
                          const SizedBox(height: 20,),
                          ElevatedButton.icon(
                              onPressed: (){

                              },
                              label: const Text('Make payment', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              icon: const Icon(Icons.mobile_friendly),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                minimumSize: const Size(double.infinity, 50)
                          ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
