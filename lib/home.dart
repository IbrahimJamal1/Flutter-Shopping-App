import 'package:ecommerce/laptop.dart';
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

List<Widget> bottomnavig = [LaptopScreen(), Tv(), Phone()];

class _HomeState extends State<Home> {
  int rating = 0;
  int selectindec = 0;
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final prod = context.watch<CartProvider>();

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
            icon: const Icon(Icons.menu_rounded, color: Colors.black, size: 30),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
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
                    size: 30,
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
                    child: Text(
                      "${prod.cartItems.length}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
              padding: const EdgeInsets.only(top: 50, bottom: 20),
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    user.email,
                    style: const TextStyle(color: Colors.white70, fontSize: 17),
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
              leading: const Icon(
                Icons.person_add_alt_1,
                color: Color(0xFF0D47A1),
              ),
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
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
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

                  GoogleSignIn googleSignIn = GoogleSignIn.instance;
                  googleSignIn.disconnect();

                  Navigator.pushReplacementNamed(context, "log");
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

    filtered.addAll(
      phoneDev.where((item) {
        return item["name"].toLowerCase().contains(query.toLowerCase());
      }).toList(),
    );

    filtered.addAll(
      tvDev.where((item) {
        return item["name"].toLowerCase().contains(query.toLowerCase());
      }).toList(),
    );

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
