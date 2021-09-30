import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/model/movie.dart';
import 'package:flutter_application_1/model/questions.dart';

class MovielistView extends StatelessWidget {
  final List<Movie> movieDetails = Movie.getMovie();
  final Movie? movie;
  final List movies = [
    "Titanic",
    "Blade Runnner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I am legend",
    "300",
    "The wolf of wall street",
    "Intersteller",
    "Game of throne",
    "Vikings"
  ];

  MovielistView({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Movies")),
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey.shade900,
      body: ListView.builder(
          itemCount: movieDetails.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              Positioned(
                  top: 10.0, child: movieCard(movieDetails[index], context)),
              movieImage(movieDetails[index].images![0]),
            ]);
            //    return Card(
            //    elevation: 4.5,
            //  color: Colors.white,
            // child: ListTile(
            //   leading: CircleAvatar(
            //   child: Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: NetworkImage(movieDetails[index].images![0]),
            //     fit: BoxFit.cover),
            // color: Colors.blue,
            //  borderRadius: BorderRadius.circular(13.9)),
            // child: null,
            // ),
            // ),
            // trailing: Text("..."),
            //title: Text(movieDetails[index].title ?? "default value"),
            // subtitle: Text(movieDetails[index].title ?? "default value"),
            //  onTap: () => {
            //  Navigator.push(
            // context,
            //   MaterialPageRoute(
            //         builder: (context) => MovieListdetails(
            //                 movieName: movieDetails[index].title,
            //                 )))
            //     },
            //onTap: () => {debugPrint("Movie name ${movies[index]}")},
            //     ),
            //     );
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60.0),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.title ?? "default title",
                        style: TextStyle(fontSize: 17.0, color: Colors.white),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: Text(
                              "rating: ${movie.imbdrating ?? "default rating"}/10",
                              style: TextStyle(
                                  fontSize: 17.0, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(movie.released ?? "released",
                          style:
                              TextStyle(fontSize: 17.0, color: Colors.white)),
                      Text(movie.runtime ?? "runtime",
                          style:
                              TextStyle(fontSize: 17.0, color: Colors.white)),
                      Text(movie.rated ?? "rated",
                          style: TextStyle(fontSize: 17.0, color: Colors.white))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieListdetails(
                      posters: movie.images,
                      cast: movie.actors,
                      director: movie.director,
                      movie: this.movie,
                      title: movie.title,
                      plot: movie.plot,
                      year: movie.year,
                      genre: movie.genre,
                      movieName: movie.title,
                      movieImage: movie.images![0],
                    )));
      },
    );
  }

  Widget movieImage(String url) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    );
  }
}

class MovieListdetails extends StatelessWidget {
  final List<String>? posters;
  final Movie? movie;
  final String? movieImage;
  final String? movieName;
  final String? year;
  final String? genre;
  final String? title;
  final String? plot;
  final String? cast;
  final String? director;
  const MovieListdetails(
      {Key? key,
      this.movie,
      this.movieImage,
      this.movieName,
      this.year,
      this.genre,
      this.title,
      this.plot,
      this.cast,
      this.posters,
      this.director})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieThumbnail(
            thumbnail: movieImage ?? "default image",
          ),
          MovieHeaderwithPoster(
              cast: this.cast,
              director: this.director,
              title: title,
              plot: plot,
              movie: this.movie,
              movieImage: movieImage,
              year: year,
              genre: genre),
          HorizontalLine(),
          MovieDetailsCast(
            cast: this.cast,
            director: this.director,
          ),
          HorizontalLine(),
          MoreMoviePosters(posters: this.posters)
        ],
      ),
      // body: Center(
      // child: Container(
      // child: RaisedButton(
      // onPressed: () => {Navigator.pop(context)},
      //child: Text("Go back ${this.movieName}"),
      //),
    );
  }
}

class MovieThumbnail extends StatelessWidget {
  final String? thumbnail;

  const MovieThumbnail({Key? key, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail ?? "default image"),
                      fit: BoxFit.cover)),
            ),
            Icon(
              Icons.play_circle_fill_outlined,
              size: 100,
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          height: 80,
        ),
      ],
    );
  }
}

class MovieHeaderwithPoster extends StatelessWidget {
  final String? movieImage;
  final Movie? movie;
  final String? year;
  final String? genre;
  final String? title;
  final String? plot;
  final String? cast;
  final String? director;

  const MovieHeaderwithPoster(
      {Key? key,
      this.movieImage,
      this.movie,
      this.year,
      this.genre,
      this.title,
      this.plot,
      this.director,
      this.cast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(children: [
        MoviePoster(poster: movieImage),
        SizedBox(
          width: 40,
        ),
        Expanded(
            child: MovieDetailsBlog(
                cast: cast,
                director: director,
                title: title,
                plot: plot,
                genre: genre,
                year: year))
      ]),
    );
  }
}

class MovieDetailsBlog extends StatelessWidget {
  final Movie? movie;
  final String? genre;
  final String? year;
  final String? title;
  final String? plot;
  final String? cast;
  final String? director;

  const MovieDetailsBlog(
      {Key? key,
      this.movie,
      this.genre,
      this.year,
      this.plot,
      this.title,
      this.cast,
      this.director})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "${this.year} . ${this.genre} ".toUpperCase(),
            style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.w400),
          ),
          Text(
            "${this.title}",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
          ),
          Text.rich(TextSpan(
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              children: [
                TextSpan(text: this.plot),
                TextSpan(text: "More", style: TextStyle(color: Colors.indigo))
              ]))
        ],
      ),
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final String? cast;
  final String? director;

  const MovieDetailsCast({Key? key, this.cast, this.director})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          MovieField(field: "Cast :", value: cast),
          MovieField(
            field: "Directors : ",
            value: director,
          )
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String? field;
  final String? value;

  const MovieField({Key? key, this.field, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$field",
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w300,
                fontSize: 12)),
        Expanded(
          child: Text(
            value ?? "default value",
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w300,
                fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 0.5,
        color: Colors.black,
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String? poster;

  const MoviePoster({Key? key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderradius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderradius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(poster ?? "default poster")),
          ),
        ),
      ),
    );
  }
}

class MoreMoviePosters extends StatelessWidget {
  final List<String>? posters;

  const MoreMoviePosters({Key? key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "More Movie Posters".toUpperCase(),
        style: TextStyle(color: Colors.black26, fontSize: 14),
      ),
      Container(
        height: 200,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(posters![index]))),
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  width: 8.0,
                ),
            itemCount: posters!.length),
      ),
    ]);
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _questionIndex = 0;
  List questionBank = [
    Question.name("Pakistan got it's independance in the year 1947", true),
    Question.name(
        "Supreme Court is the greatest court according to the constitution of Pakistan",
        true),
    Question.name("Allama Iqbal is the founder of Pakistan", false),
    Question.name("Constitution of Pakistan has 35 amendents", false),
    Question.name("The prime minister of Pakistan must be a muslim", true),
    Question.name("Karachi is the capital of Pakistan", false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Citizen"),
        centerTitle: true,
        // backgroundColor: Colors.blueGrey,
      ),
      //backgroundColor: Colors.blueGrey,
      body: Builder(
        builder: (BuildContext context) => Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/flag.png",
                  height: 180,
                  width: 250,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 120.0,
                    child: Center(
                        child: Text(
                      questionBank[_questionIndex].questionText,
                      //  style: TextStyle(fontSize: 16.9, color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Colors.blueGrey.shade400,
                          style: BorderStyle.solid,
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () => _prevQuestion(),
                      color: Colors.blueGrey.shade900,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () => _checkanswer(true, context),
                      color: Colors.blueGrey.shade900,
                      child: Text(
                        "TRUE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () => _checkanswer(false, context),
                      color: Colors.blueGrey.shade900,
                      child: Text(
                        "FALSE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () => _nextQuestion(),
                      color: Colors.blueGrey.shade900,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _checkanswer(bool userChoice, BuildContext context) {
    if (userChoice == questionBank[_questionIndex].iscorrect) {
      final snackbar = SnackBar(
        backgroundColor: Colors.greenAccent,
        content: Text("Correct"),
        duration: Duration(milliseconds: 500),
      );
      Scaffold.of(context).showSnackBar(snackbar);
      _updateQuestion();
      debugPrint("Yes CORRECT");
    } else {
      final snackbar = SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("WRONG"),
        duration: Duration(milliseconds: 500),
      );
      Scaffold.of(context).showSnackBar(snackbar);
      _updateQuestion();
      debugPrint("NO, you are wrong :(");
    }
  }

  _updateQuestion() {
    setState(() {
      _questionIndex = (_questionIndex + 1) % questionBank.length;
    });
  }

  _nextQuestion() {
    _updateQuestion();
  }

  _prevQuestion() {
    setState(() {
      _questionIndex = (_questionIndex - 1) % questionBank.length;
    });
  }
}

class Tipsplitter extends StatefulWidget {
  @override
  _TipsplitterState createState() => _TipsplitterState();
}

class _TipsplitterState extends State<Tipsplitter> {
  int _tipPercent = 0;
  int _personCount = 1;
  double _billAmount = 0.00;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.purpleAccent.shade400.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Per Person",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Colors.purple,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "\$123",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34.0,
                          color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(12.5),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount",
                        icon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCount > 1) {
                                  _personCount--;
                                }
                                //do nothing
                              });
                            },
                            child: Center(
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.purple.shade400
                                        .withOpacity(0.1)),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCount",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCount++;
                              });
                            },
                            child: Center(
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color:
                                      Colors.purple.shade400.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                                child: Center(
                                  child: Text("+",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "\$ ${calculateTotaltip(_billAmount, _personCount, _tipPercent)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade700,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$_tipPercent%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          inactiveColor: Colors.grey,
                          activeColor: Colors.purple,
                          divisions: 10,
                          value: _tipPercent.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercent = newValue.round();
                              debugPrint(_tipPercent.toString());
                            });
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculatetotalperperson(double totalTip, double billAmount, int splitBy) {
    var totalperperson = (totalTip + billAmount) / splitBy;
    return totalperperson;
  }

  calculateTotaltip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    debugPrint(totalTip.toString());
    return totalTip;
  }
}

class Wisdom extends StatefulWidget {
  @override
  _WisdomState createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int index = 0;
  List quotes = [
    "Youre off to great places, today is your day. Your mountain is waiting, so get on your way.",
    ' You always pass failure on the way to success.',
    'No one is perfect - that’s why pencils have erasers'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 350,
                height: 200,
                margin: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14.5)),
                child: Center(
                    child: Text(
                  quotes[index % quotes.length],
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13.4),
                ))),
            Divider(
              thickness: 1.3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              // ignore: deprecated_member_use
              child: FlatButton.icon(
                  color: Colors.greenAccent.shade700,
                  onPressed: _getQuote,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("Inspire me")),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void _getQuote() {
    setState(() {
      index++;
    });
  }
}

class BizCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biz Card"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [_getcard(), _getAvatar()],
        ),
      ),
    );
  }

  Container _getcard() {
    return Container(
      height: 200,
      width: 350,
      margin: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Manzur Ahmad Mitha Khan Qaisrani",
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
          Text("Qaisrani Kot, New Shalimar Colony"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.person_outline), Text("@code_with_me")],
          )
        ],
      ),
    );
  }

  Container _getAvatar() {
    return Container(
        alignment: Alignment.topRight,
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: Colors.redAccent, width: 1.2),
          image: DecorationImage(
              image: NetworkImage("https://picsum.photos/200/300"),
              fit: BoxFit.cover),
        ));
  }
}

class Scaffold_Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Scaffold Example"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => debugPrint("icon tapped"),
                icon: Icon(Icons.email))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => debugPrint("floating is pressed"),
            child: Icon(Icons.call_missed),
            backgroundColor: Colors.green),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.email), label: "First"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Second"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Third")
        ], onTap: (int index) => {debugPrint("$index")}),
        backgroundColor: Colors.redAccent,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [custom_button()],
          ),
        ));
  }
}

class custom_button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackbar = SnackBar(content: Text("This is snackbar,  bitch"));
        Scaffold.of(context).showSnackBar(snackbar);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(8.0)),
        child: Text("Button"),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey,
      child: Center(
          child: Text(
        "Hello",
        textDirection: TextDirection.ltr,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            fontStyle: FontStyle.italic),
      )),
    );
  }
}
