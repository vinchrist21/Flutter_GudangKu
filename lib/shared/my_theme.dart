part of 'shared.dart';

class MyTheme{

  static ThemeData lightTheme(){
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      backgroundColor: Color(0xFFf2f2f2),//kalo pake code warna harus ada 0xFF
      scaffoldBackgroundColor: Color(0xFFf2f2f2),
      primaryColor: Colors.deepOrange[400],
      accentColor: Colors.deepOrange[400],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }

  static ThemeData darkTheme(){
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      backgroundColor: Color(0xFF2D142C),//kalo pake code warna harus ada 0xFF
      scaffoldBackgroundColor: Color(0xFF2D142C),
      primaryColor: Color(0xFFC72C41),
      accentColor: Colors.white70,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.lato().fontFamily,
    );
  }

}