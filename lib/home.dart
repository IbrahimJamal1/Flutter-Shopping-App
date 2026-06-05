import 'package:ecommerce/tv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/main.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providerapp.dart';
import 'package:ecommerce/phone.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<Widget> bottomnavig = [

  LaptopScreen(),
  Tv(), 
  Phone(),

];

class _HomeState extends State<Home> {
  int rating = 0;
  int selectindec = 0;
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectindec,
        onTap: (val) {
          setState(() {
            selectindec = val;
          });
        },

        selectedFontSize: 20,
        selectedItemColor: Colors.red,
        selectedLabelStyle: TextStyle(fontSize: 20),

        unselectedFontSize: 18,
        unselectedItemColor: Colors.blue,
        unselectedLabelStyle: TextStyle(fontSize: 18),

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.laptop), label: "Labtop"),

          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV"),

          BottomNavigationBarItem(icon: Icon(Icons.smartphone), label: "Phone"),
        ],
      ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "MegaDevices",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.black,
              size: 28,
            ),
          ),

          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "cart");
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                    size: 28,
                  ),
                ),

                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "0",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [

            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 20),
              color: const Color(0xFF0D47A1),
              child: Column(
                children: [

                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Color(0xFF0D47A1),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    user.email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// PRODUCTS
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFF0D47A1)),
              title: const Text("Products"),
              onTap: () {
                Navigator.of(context).pushNamed("home");
              },
            ),

            /// ADD ACCOUNT
            ListTile(
              leading: const Icon(Icons.person_add_alt_1, color: Color(0xFF0D47A1)),
              title: const Text("Add Account"),
              onTap: () {
                Navigator.of(context).pushNamed("main");
              },
            ),

            /// ABOUT
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFF0D47A1)),
              title: const Text("About"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      title: const Text("About Us"),
                      content: const Text(
                        "Eng. Ibrahim Gamal\n"
                        "📞 01099687160\n"
                        "📧 ibrahimgamal932@gmail.com",
                      ),
                    );
                  },
                );
              },
            ),

            /// RATING
            ListTile(
              leading: const Icon(Icons.star_border, color: Color(0xFF0D47A1)),
              title: const Text("Rating"),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setStateSheet) {
                        return SizedBox(
                          height: 140,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return IconButton(
                                iconSize: 35,
                                onPressed: () {
                                  setStateSheet(() {
                                    rating = index + 1;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  color: index < rating
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),

            const Spacer(),

            /// LOGOUT
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(

                onTap: () async {
                  context.read<UserProvider>().logout();
                  await FirebaseAuth.instance.signOut();
                  
                  GoogleSignIn googleSignIn = GoogleSignIn.instance  ;
                  googleSignIn.disconnect();
                },

                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

      body: bottomnavig.elementAt(selectindec),
    );
  }
}

class LaptopScreen extends StatelessWidget {
  const LaptopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: laptopDev.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// IMAGE
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    laptopDev[index]["imag"],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// NAME
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  laptopDev[index]["name"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              /// PRICE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "${laptopDev[index]["price"]} \$",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// BUTTON
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    context.read<CartProvider>().addcart(
                      laptopDev[index]["price"],
                      laptopDev[index]["name"],
                      laptopDev[index]["imag"],
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to cart ✅"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  color: const Color(0xFF0D47A1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filtered = laptopDev.where((item) {
      return item["name"].toLowerCase().contains(query.toLowerCase());
    }).toList();

    filtered.addAll(phoneDev.where((item) {
      return item["name"].toLowerCase().contains(query.toLowerCase());
    }).toList());

    filtered.addAll(tvDev.where((item) {
      return item["name"].toLowerCase().contains(query.toLowerCase());
    }).toList());

    if (query.isEmpty) {
      return Center(child: Text("Search Prodects..."));
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(
            filtered[index]["imag"],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(filtered[index]["name"]),
          subtitle: Text("${filtered[index]["price"]} \$"),
          onTap: () {
            query = filtered[index]["name"];
            showResults(context);
          },
        );
      },
    );
  }
}
