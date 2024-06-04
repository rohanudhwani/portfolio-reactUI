import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navbar',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Aksans"),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Color(0xFF23272F),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                child: MyAppBar(),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    NameWidget(),
                    SkillsWidget(),
                    ExperienceWidget(),
                    ProjectsWidget(),
                  ],
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class ProjectsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 30),
            color: Color(0xFF181A1F),
            child: Column(
              children: [
                Text(
                  "Join a network of successful projects",
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Text(
                  "You’re not alone. Countless businesses and individuals have benefited from the expertise offered here. By leveraging innovative solutions and top-notch skills, these projects have made significant impacts in their respective fields.",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                SlidingImagesCarousel(),
              ],
            )));
  }
}

Widget SlidingImagesCarousel() {
  return SizedBox(
    height: 700, // Set a fixed height for the carousel
    child: ListView(
      scrollDirection: Axis.horizontal, // Make the list scroll horizontally
      children: [
        CarouselSlider(
            items: [
              CustomImageContainer(
                  imagePath: 'assets/carousel1.jpg', rotationAngle: 2),
              CustomImageContainer(
                  imagePath: 'assets/carousel2.jpg', rotationAngle: -2),
              CustomImageContainer(
                  imagePath: 'assets/carousel3.jpeg', rotationAngle: 2),
              CustomImageContainer(
                  imagePath: 'assets/carousel4.jpeg', rotationAngle: -2),
              CustomImageContainer(
                  imagePath: 'assets/carousel5.jpeg', rotationAngle: 2),
              CustomImageContainer(
                  imagePath: 'assets/carousel6.jpeg', rotationAngle: -2),
              CustomImageContainer(
                  imagePath: 'assets/carousel7.jpeg', rotationAngle: 2),
              CustomImageContainer(
                  imagePath: 'assets/carousel8.gif', rotationAngle: -2),
              CustomImageContainer(
                  imagePath: 'assets/carousel9.gif', rotationAngle: 2),
              CustomImageContainer(
                  imagePath: 'assets/carousel10.jpg', rotationAngle: -2),
              CustomImageContainer(
                  imagePath: 'assets/carousel11.jpg', rotationAngle: 2),
              CustomImageContainer(
                  imagePath: 'assets/carousel12.png', rotationAngle: -2),
              CustomImageContainer(
                  imagePath: 'assets/carousel13.gif', rotationAngle: 2),
            ],
            options: CarouselOptions(
              viewportFraction: 0.2,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
            ))
      ],
    ),
  );
}

class CustomImageContainer extends StatefulWidget {
  final String imagePath;
  final double rotationAngle;

  const CustomImageContainer({
    Key? key,
    required this.imagePath,
    this.rotationAngle = 0,
  }) : super(key: key);

  @override
  _CustomImageContainerState createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomImageContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Transform.rotate(
              angle: isHovered ? 0 : widget.rotationAngle * (3.14159 / 180),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.fitWidth,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: isHovered
                          ? Colors.black.withOpacity(0.3)
                          : Colors.transparent,
                      blurRadius: isHovered ? 10 : 0,
                    ),
                  ],
                  gradient: isHovered
                      ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0),
                          ],
                        )
                      : null,
                ),
              ),
            )));
  }
}

class ExperienceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.only(left: 60, right: 40, top: 50, bottom: 30),
        color: Color(0xFF1D1F26),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Experience leading impactful projects and teams",
                        style: TextStyle(fontSize: 45, color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "With extensive experience in community management, event leadership, and technical club activities, this individual has proven their capabilities in various roles. As a Community Manager Intern at NBLIK, they expanded the user base and increased engagement by implementing effective strategies, driving significant revenue growth, and improving app performance through user feedback.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "As Secretary General for TantraFiesta 2023, they achieved a footfall of over 5000 attendees and secured sponsorships exceeding 5 lakhs, demonstrating adept event management and budget handling. As Club Head of Crescendo at IIIT Nagpur, they mentored students in music, generated revenue through GearBox Rentals, and enhanced music quality through studio visits.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 22),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: _buildBox(
                                  "BlinkX by JM Financial",
                                  "Mobile Fullstack Developer Intern",
                                  "May 21, 2024 - Feb 21, 2025")),
                          SizedBox(width: 17),
                          Expanded(
                              child: _buildBox(
                                  "NbliK",
                                  "Community Manager Intern",
                                  "March 2 - April 3, 2023")),
                        ],
                      ),
                      SizedBox(height: 50),
                      Row(
                        children: [
                          Expanded(
                              child: _buildBox(
                                  "TantraFiesta'23",
                                  "Secretary General",
                                  "June 4, 2023 - Nov 7, 2024")),
                          SizedBox(width: 17),
                          Expanded(
                              child: _buildBox("Abhivyakti'24", "Advisor",
                                  "Nov 9, 2023 - April 11, 2024")),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              color: Color(0xFF1D1F26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // Handle your click event here
                      Navigator.pushNamed(context, '/blog');
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.article,
                            color: Colors.blue,
                            size: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Know more about my journey',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBox(String companyName, String position, String duration) {
    return Container(
        height: 170,
        padding: EdgeInsets.only(top: 8, left: 10, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.white, width: 0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              companyName,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            SizedBox(height: 10),
            Text(
              position,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 3),
                SizedBox(width: 5),
                Text(
                  duration,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ],
            ),
          ],
        ));
  }
}

class SkillsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.only(left: 200, right: 200, top: 70, bottom: 30),
        color: Color(0xFF181A1F), // Background color #181A1F
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Building bridges between user experience and functionality, one line of code at a time.",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
            Text("", style: TextStyle(color: Colors.white, fontSize: 30.0)),
            Center(
              child: CustomTextWidget(),
            ),
            SizedBox(height: 30),
            EducationWidget(),
          ],
        ),
      ),
    );
  }
}

class EducationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Education container
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF23272F), // Background color #16181D
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.white, // White border color
                width: 0.1, // Border width
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 20),
                  child: Text(
                    'Education.js',
                    style: TextStyle(
                      color: Colors.white, // Header color #23272F
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  color: Color(0xFF16181D), // Code block background color
                  padding: EdgeInsets.all(13.0),
                  child: Text(
                    '''function Education({ education }) {
  return (
    <div>
      <Degree institute={iiit.nagpur}>
        <course>B.Tech in Computer Science and Engineering</course>
        <year>2021-2025</year>
      </Degree>
      <HigherSecondary school={Orchids The International School, Thane} board={CBSE} result={90.8%}/>
      <Matriculation institute={D.A.V. Public School, Thane} board={CBSE} result={94.2%} />
    </div>
  );
}''',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.5, // 10% less height
            width: MediaQuery.of(context).size.width *
                0.35, // Adjust width as needed
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF313049),
                  Color(0xFF292D38),
                  Color(0xFF193849),
                  Color(0xFF1B3C44),
                  Color(0xFF1C3F3F),
                  Color(0xFF313049)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "3 Educations",
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset('assets/iiitn_logo.png', height: 40.0),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "IIIT Nagpur",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "B.Tech in Computer Science and Engineering",
                                style: TextStyle(fontSize: 13.0),
                              ),
                              Text(
                                "2021-2025",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.school, color: Colors.black),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset('assets/orchids_logo.jpg', height: 40.0),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Orchids The International School, Thane",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Higher Secondary",
                                style: TextStyle(fontSize: 13.0),
                              ),
                              Text(
                                "90.8%",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.school, color: Colors.black),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset('assets/dav_logo.png', height: 40.0),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "D.A.V. Public School, Thane",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Matriculation",
                                style: TextStyle(fontSize: 13.0),
                              ),
                              Text(
                                "94.2%",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.school, color: Colors.black),
                      ],
                    ),
                  ],
                ))),
      ],
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            height: 1.5,
          ),
          children: [
            TextSpan(
                text:
                    "Highly motivated full-stack developer with expertise in "),
            _highlightedText("Java"),
            TextSpan(text: ", "),
            _highlightedText("Python"),
            TextSpan(text: ", "),
            _highlightedText("React Native"),
            TextSpan(text: ", "),
            _highlightedText("JavaScript"),
            TextSpan(text: ", "),
            _highlightedText("Node.js"),
            TextSpan(text: ", "),
            _highlightedText("MongoDB"),
            TextSpan(text: ", and "),
            _highlightedText("Firebase"),
            TextSpan(
                text:
                    ". Skilled in creating seamless interfaces and robust backend solutions. Strong problem-solving, critical thinking, and communication abilities. Ready to tackle new challenges and deliver exceptional results. Connect to achieve your development goals."),
          ],
        ),
      ),
    );
  }

  WidgetSpan _highlightedText(String text) {
    return WidgetSpan(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7.0),
        decoration: BoxDecoration(
          color: Color(0xFF404756),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(height: 70),
        Image.asset(
          'assets/logo.png', // Ensure you have the logo in your assets
          height: 150.0,
        ),
        SizedBox(height: 35),
        Text(
          'Rohan Udhwani',
          style: TextStyle(
              color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 35),
        Text(
          'Building intuitive and high-performance mobile apps',
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize:
              MainAxisSize.min, // Aligns items vertically in the center
          children: [
            ElevatedButton(
              onPressed: () => launchURL('tel:9967667361'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF58C4DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded borders
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 20, horizontal: 20), // Adjust padding as needed
                minimumSize: Size(30, 10),
              ),
              child: Text(
                'Contact Now',
                style: TextStyle(
                  color: Color(0xFF404756),
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(width: 20), // Add spacing between buttons if needed
            OutlinedButton(
              onPressed: () => launchURL(
                  'https://play.google.com/store/apps/developer?id=Rohan+Udhwani'),
              style: OutlinedButton.styleFrom(
                side:
                    BorderSide(color: Color(0xFF58C4DC)), // Light border color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded borders
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 20, horizontal: 20), // Adjust padding as needed
                minimumSize: Size(30, 10),
              ),
              child: Text(
                'See Projects',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 80)
      ],
    ));
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF23272F),
      elevation: 0,
      title: Container(
        padding: EdgeInsets.only(top: 15, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Logo
            Row(
              children: [
                Image.asset(
                  'assets/logo.png', // Ensure you have the logo in your assets
                  height: 40.0,
                ),
                SizedBox(width: 5),
                Text(
                  'v20.9.22',
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ],
            ),
            // Search bar
            SizedBox(width: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Center the row's children horizontally
              children: [
                Container(
                  width: 600,
                  height: 40,
                  child: Center(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF333A45),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey),
                        hintFadeDuration: Duration(milliseconds: 800),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: IntrinsicWidth(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Text(
                                  "Ctrl",
                                  style: TextStyle(
                                    color: Color(0xFF939BAC),
                                    fontSize: 12,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xFF23272F),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Text(
                                  "k",
                                  style: TextStyle(
                                    color: Color(0xFF939BAC),
                                    fontSize: 12,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xFF23272F),
                                ),
                              ),
                              SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 15),
            // Buttons
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () =>
                      launchURL('https://in.linkedin.com/in/rohanudhwani'),
                  child: Text(
                    'Linkedin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () => launchURL('https://github.com/rohanudhwani'),
                  child: Text(
                    'Github',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () =>
                      launchURL('https://leetcode.com/u/rohanudhwani/'),
                  child: Text(
                    'Leetcode',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () => launchURL('tel:9967667361'),
                  child: Text(
                    'Contact',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ],
            ),
            //Buttons
            SizedBox(width: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.dark_mode_rounded, color: Colors.white),
                SizedBox(width: 25), // Add spacing between icons if needed
                Icon(Icons.language, color: Colors.white),
                SizedBox(width: 25), // Add spacing between icons if needed
                Image.asset('assets/github_logo.png',
                    height: 30.0), // Ensure the correct asset path
              ],
            )
          ],
        ),
      ),
    );
  }
}
