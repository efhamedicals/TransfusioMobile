import 'package:flutter_dotenv/flutter_dotenv.dart';

// String's Constants for app
const String appTitle = "Transfusio";

const themeUser = 'themeUser';
const langUser = 'langUser';
const String userData = "userData";
const String userTokenAuth = "tokenAuth";

// Networking and APIs
String baseUrl = dotenv.get('BASE_URL');
