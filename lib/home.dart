import 'package:flutter/material.dart';
import 'package:ecommerce/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MegaDevices"),
        backgroundColor: Color(0xFF0D47A1),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(Icons.search, size: 30),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart, size: 30),
          ),
        ],
      ),

      drawer: Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            children: [

              Container(
                color: Color(0xFF0D47A1),
                child: ListTile(
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    name ?? "Guest",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  subtitle: Text(
                    email ?? "No Email",
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person),
                  ),
                ),
              ),

              
              buildTile("Home", Icons.home, () {
                Navigator.of(context).pushNamed("main");
              }),

              buildTile("Products", Icons.shop, () {
                Navigator.of(context).pushNamed("home");
              }),

              buildTile("About", Icons.info, () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Color(0xFF0D47A1),
                      title: Text(
                        "About Us",
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Text(
                        "eng.ibrahim gamal\nphone:01099687160\nemail: ibrahimgamal932@gmail.com",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                );
              }),

              // ⭐ Rating
              buildTile("Rate App", Icons.star, () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setStateSheet) {
                        return Container(
                          height: 150,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return IconButton(
                                iconSize: 40,
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
              }),

            ],
          ),

          // 🔴 Logout
          Container(
            margin: EdgeInsets.all(10),
            child: ListTile(
              tileColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                "Log out",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.logout, color: Colors.white),
              onTap: () {
                setState(() {
                  name = "MegaDevices";
                  email = "MegaDevices@gmail.com";
                });
                Navigator.of(context).pushNamed("log");
              },
            ),
          ),

        ],
      ),
    ),

      
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: product.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    product[index]["imag"],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Text(product[index]["name"]),
                Text("${product[index]["price"]} \$"),
                MaterialButton(
                  onPressed: (){

                    //my cart

                  },
                  color: Colors.blue,
                  minWidth: 1000,

                  child: Text("add cart",style: TextStyle(fontSize: 25,color: Colors.white),),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Icon(icon),
      onTap: onTap,
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
    List filtered = product.where((item) {
      return item["name"].toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (query.isEmpty) {
      return Center(child: Text("Search products..."));
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(
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