import "dart:math";
import "dart:html" as dartHTML;
import 'dart:io' as dartIO;
import 'dart:async' as dartAsync;
import "dart:convert";
import 'package:characters/characters.dart';

// https://dart.dev/guides/language/language-tour#the-main-function
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');

  /* --- */
  print('usingParameterizedTypesWithConstructors');
  usingParameterizedTypesWithConstructors();
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#string-interpolation
*/
void stringInterpolation() {
  int number = 1;
  String word = 'ops';
  String interpolation = '$number $word';

  print("interpolation: $interpolation");

  String calcInterpolation = '${3 + 2}';
  print("calcInterpolation: $calcInterpolation");

  String callFunctionInterpolation = '${"upper case me".toUpperCase()}';
  print("callFunctionInterpolation: $callFunctionInterpolation");
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#nullable-variables
*/
void nullableVariables() {
  /*
  int invalidNullSafetyNull = null; // do not work with null safety
  print(invalidNullSafetyNull);
  */

  int? nullSafetyNull = null; // dart sdk version >= 2.12
  print(nullSafetyNull);
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#null-aware-operators
*/
void nullAwareOperators() {
  int? nullVar;

  nullVar ??= 3;
  print(nullVar);

  print('1 ?? 3 = ${1 ?? 3}');
  print('null ?? 12 = ${null ?? 12}');
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#conditional-property-access
*/
class Person{
  String? name;
  int? age;

  Person({ this.name, this.age });
}

void conditionalPropertyAccess() {
  Person fullPerson = Person(name:"Ram", age: 18);
  Person noNamePerson = Person(age: 0);

  print(fullPerson?.name);
  print(noNamePerson?.name);
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#collection-literals
*/
void collectionLiterals() {
  final aListOfStrings = ['one', 'two', 'three'];
  print(aListOfStrings);
  
  final aSetOfStrings = {'one', 'two', 'three'};
  print(aSetOfStrings);

  final aMapOfStringsToInts = {
    'one': 1,
    'two': 2,
    'three': 3,
  };
  print(aMapOfStringsToInts);

  final aListOfInts = <int>[];
  print(aListOfInts);

  final aSetOfInts = <int>{};
  print(aSetOfInts);

  final aMapOfIntToDouble = <int, double>{};
  print(aMapOfIntToDouble);

  // final aListOfBaseType = <BaseType>[SubType(), SubType()];
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#arrow-syntax
*/
void arrowSyntax() {
  const aListOfStrings = ['a', 'b', 'c'];
  bool hasEmpty = aListOfStrings.any((s) => s.isEmpty);
  print(hasEmpty);

  const emptyStringList = [''];
  hasEmpty = emptyStringList.any((s) => s.isEmpty);
  print(hasEmpty);
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#cascades
*/
class BigObject {
  int anInt = 0;
  String aString = '';
  List<double> aList = [];
  bool _done = false;
  
  void allDone() {
    _done = true;
  }
}
void cascades() {
  BigObject fillBigObject(BigObject obj) {
    // Create a single statement that will update and return obj:
    return obj
      ..anInt = 4
      ..aString = "opa"
      ..aList = [1, 2, 3]
      ..allDone();
  }

  BigObject obj = BigObject();
  print(fillBigObject(obj).aList);
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#getters-and-setters
*/
class InvalidPriceException {}

class ShoppingCart {
  List<double> _prices = [];

  double get total => _prices.fold(0, (prev, element) => prev + element);

  set prices(List<double> value) {
    if (value.any((price) => price < 0)) {
      throw InvalidPriceException();
    }

    _prices = value;
  }
}

void gettersAndSetters() {
  ShoppingCart cart = ShoppingCart();

  cart.prices = [1, 2, 3];
  assert(cart.total == 6);
  print(cart.total);

  cart.prices = [1, -1]; // throw InvalidPriceException
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#optional-positional-parameters
*/
String joinWithCommas(int a, [int? b, int? c, int? d, int? e]) {
  String sum = '${a}';
  
  if (b != null) sum = '$sum,$b';
  if (c != null) sum = '$sum,$c';
  if (d != null) sum = '$sum,$d';
  if (e != null) sum = '$sum,$e';
  
  return sum;
}

void optionalPositionalParameters() {
  print(joinWithCommas(1, 2, 3));
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#optional-named-parameters
*/
class MyDataObject {
  final int anInt;
  final String aString;
  final double aDouble;

  MyDataObject({
     this.anInt = 1,
     this.aString = 'Old!',
     this.aDouble = 2.0,
  });

  // Add your copyWith method here:
  MyDataObject copyWith({int? newInt, String? newString, double? newDouble}) => 
    MyDataObject(
      anInt: newInt ?? this.anInt,
      aString: newString ?? this.aString,
      aDouble: newDouble ?? this.aDouble,
    );
}

void optionalNamedParameters() {
  MyDataObject dataObj = MyDataObject();

  print('Original:');
  print(dataObj.anInt);
  print(dataObj.aString);
  print(dataObj.aDouble);

  MyDataObject copyDataObj = dataObj.copyWith(newInt: 99,newDouble: 3.9);
  print('Copy with new values:');
  print(copyDataObj.anInt);
  print(copyDataObj.aString);
  print(copyDataObj.aDouble);
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#exceptions
*/
typedef VoidFunction = void Function();

class ExceptionWithMessage {
  final String message;
  const ExceptionWithMessage(this.message);
}

// Call logException to log an exception, and doneLogging when finished.
abstract class Logger {
  void logException(Type t, [String? msg]);
  void doneLogging();
}

void tryFunction(VoidFunction untrustworthy, Logger logger) {
  // Invoking this method might cause an exception. Catch and handle
  // them using try-on-catch-finally.
  
  try {
    untrustworthy();
  } on ExceptionWithMessage catch (e) {
    logger.logException(e.runtimeType, e.message);
  } on Exception {
    logger.logException((Exception));
  } finally {
    logger.doneLogging();
  }
  
}

class MyLogger extends Logger {
  Type? lastType;
  String lastMessage = '';
  bool done = false;
  
  void logException(Type t, [String? message]) {
    lastType = t;
    lastMessage = message ?? lastMessage;
  }
  
  void doneLogging() => done = true;  
}

void exceptions() {
  var logger = MyLogger();

  tryFunction(() => throw Exception(), logger);
  print('${logger.lastType} ${logger.lastMessage}');

  tryFunction(() => throw ExceptionWithMessage('Hey!'), logger);
  print('${logger.lastType} ${logger.lastMessage}');

  tryFunction(() {}, logger); // No exception, repeat last execution
  print('${logger.lastType} ${logger.lastMessage}');

  tryFunction(() => throw 'A String', logger); // Unhandled exception
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#using-this-in-a-constructor
*/
class MyNamedParameterClass {
  final int anInt;
  final String aString;
  final double aDouble;
  
  // Create a constructor here.
  MyNamedParameterClass({required this.anInt, required this.aString, required this.aDouble});
}

class MyPositionalParameterClass {
  final int anInt;
  final String aString;
  final double aDouble;
  
  // Create a constructor here.
  MyPositionalParameterClass(this.anInt, this.aString, this.aDouble);
}

void usingThisInAConstructor() {
  MyNamedParameterClass(aDouble: 0.5, aString: 'invert', anInt: 10);
  MyPositionalParameterClass(10, 'string', 0.5);
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#initializer-lists
*/
class FirstTwoLetters {
  final String letterOne;
  final String letterTwo;

  // Create a constructor with an initializer list here:
  FirstTwoLetters(String word)
    : letterOne = word[0],
      letterTwo = word[1],
      assert(word.length <= 2) {
        print('invalid word');
      }
}

void initializerLists() {
  FirstTwoLetters valid = FirstTwoLetters('12');
  print('${valid.letterOne}, ${valid.letterTwo}');

  FirstTwoLetters invalid = FirstTwoLetters('');
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#named-constructors
*/
class Color {
  int red;
  int green;
  int blue;
  
  Color(this.red, this.green, this.blue);

  // Create a named constructor called "Color.black" here:
  Color.black()
    : red = 0,
      green = 0,
      blue = 0;
}

void namedConstructors() {
  Color color = Color.black();
  print('${color.red}, ${color.green}, ${color.blue}');
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#factory-constructors
*/
class IntegerHolder {
  IntegerHolder();
  
  // Implement this factory constructor.
  factory IntegerHolder.fromList(List<int> list) {
    if (list.length == 1) {
      return IntegerSingle(list[0]);
    } else if (list.length == 2) {
      return IntegerDouble(list[0], list[1]);
    } else if (list.length == 3) {
      return IntegerTriple(list[0], list[1], list[2]);
    }

    print('I don\'t recognize');
    throw Error();
  }
}

class IntegerSingle extends IntegerHolder {
  final int a;
  IntegerSingle(this.a); 
}

class IntegerDouble extends IntegerHolder {
  final int a;
  final int b;
  IntegerDouble(this.a, this.b); 
}

class IntegerTriple extends IntegerHolder {
  final int a;
  final int b;
  final int c;
  IntegerTriple(this.a, this.b, this.c); 
}

void factoryConstructors() {
  final obj = IntegerHolder.fromList([1, 2, 3]);

  if (obj is! IntegerTriple) {
    print('it is not a IntegerTripe');
  } else {
    if (obj.a != 1) {
      print('undefined a');
    }
    print(obj.a);
    
    if (obj.b != 2) {
      print('undefined b');
    }
    print(obj.b);

    if (obj.c != 3) {
      print('undefined c');
    }
    print(obj.c);
  }
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#redirecting-constructors
*/
class ColorRedirectingConstructor {
  int red;
  int green;
  int blue;
  
  ColorRedirectingConstructor(this.red, this.green, this.blue);

  ColorRedirectingConstructor.black() : this(0, 0, 0);
}

void redirectingConstructors() {
  ColorRedirectingConstructor color = ColorRedirectingConstructor.black();
  print(color.red);
}

/*
  https://dart.dev/codelabs/dart-cheatsheet#const-constructors
*/
class Recipe {
  const Recipe(this.ingredients, this.calories, this.milligramsOfSodium);
  
  final List<String> ingredients;
  final int calories;
  final double milligramsOfSodium;

  static const Recipe recipe = Recipe(['rice', 'beans'], 1000, 50);
}

void constConstructors() {
  Recipe recipe = Recipe.recipe;
  print(recipe.ingredients);
}

/*
  https://dart.dev/codelabs/iterables#example-using-a-for-in-loop
*/
void usingAForInLoop() {
  var iterable = ['Salad', 'Popcorn', 'Toast'];

  for (var element in iterable) {
    print(element);
  }
}

/*
  https://dart.dev/codelabs/iterables#example-using-first-and-last
*/
void usingFirstAndLast() {
  Iterable iterable = ['first', 'second', 'third'];

  print('first: ${iterable.first}');
  print('last: ${iterable.last}');
}

/*
  https://dart.dev/codelabs/iterables#example-using-firstwhere
*/
bool predicate(String element) {
  return element.length > 5;
}

void usingFirstwhere() {
  var items = ['Salad', 'Popcorn', 'Toast', 'Lasagne'];

  // You can find with a simple expression:
  var element1 = items.firstWhere((element) => element.length > 5);
  print(element1);

  // Or try using a function block:
  var element2 = items.firstWhere((element) {
    return element.length > 5;
  });
  print(element2);

  // Or even pass in a function reference:
  var element3 = items.firstWhere(predicate);
  print(element3);

  // You can also use an `orElse` function in case no value is found!
  var element4 = items.firstWhere(
    (element) => element.length > 10,
    orElse: () => 'None!',
  );
  print(element4);
}

/*
  https://dart.dev/codelabs/iterables#exercise-practice-writing-a-test-predicate
*/
String singleWhere(Iterable<String> items) {
  return items.singleWhere((element) => element.startsWith('M') && element.contains('a'));
}

void writingATestPredicate() {
  print(singleWhere(['opa', 'Matter']));
}

/*
  https://dart.dev/codelabs/iterables#checking-conditions
*/
bool anyUserUnder18(Iterable<User> users) => users.any((user) => user.age < 18);

bool everyUserOver13(Iterable<User> users) => users.every((user) => user.age > 13);

class User {
  String name;
  int age;

  User(
    this.name,
    this.age,
  );
}

void checkingConditions() {
  var users = [
    User('Alice', 21),
    User('Bob', 17),
    User('Claire', 52),
    User('David', 14),
  ];

  print(anyUserUnder18(users));
  print(everyUserOver13(users));
}

/*
  https://dart.dev/codelabs/iterables#filtering
*/
Iterable<UserFiltering> filterUnder21(Iterable<UserFiltering> users) {
  return users.where((user) => user.age >= 21);
}

Iterable<UserFiltering> findShortNamed(Iterable<UserFiltering> users) {
  return users.where((user) => user.name.length <= 3);
}

class UserFiltering {
  String name = '';
  int age = 0;

  UserFiltering(
    this.name,
    this.age,
  );
}

void filtering() {
  var users = [
    UserFiltering('Alice', 21),
    UserFiltering('Bob', 17),
    UserFiltering('Claire', 52),
    UserFiltering('Dan', 12),
  ];

  Iterable<UserFiltering> under21 = filterUnder21(users);
  under21.forEach((element) => print('more than 21: ${element.name} - ${element.age}'));

  Iterable<UserFiltering> shortNames = filterUnder21(users);
  shortNames.forEach((element) => print('short name: ${element.name} - ${element.age}'));
}

/*
  https://dart.dev/codelabs/iterables#mapping
*/
Iterable<String> getNameAndAges(Iterable<UserMapping> users) => users
  .map((user) => '${user.name} is ${user.age}');

class UserMapping {
  String name = '';
  int age = 0;

  UserMapping(
    this.name,
    this.age,
  );
}

void mapping() {
  print(getNameAndAges([
    UserMapping('User1', 10),
    UserMapping('User2', 20),
    UserMapping('User3', 30),
  ]));
}

/*
  https://dart.dev/codelabs/iterables#exercise-putting-it-all-together
*/
bool isValidEmailAddress(EmailAddress email) {
  return email.address.contains('@');
}

Iterable<EmailAddress> parseEmailAddresses(Iterable<String> strings) => strings
  .map((mail) => EmailAddress(mail));

bool anyInvalidEmailAddress(Iterable<EmailAddress> emails) => emails
  .any((email) => !isValidEmailAddress(email));

Iterable<EmailAddress> validEmailAddresses(Iterable<EmailAddress> emails) => emails
  .where((email) => isValidEmailAddress(email));

class EmailAddress {
  String address;

  EmailAddress(this.address);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EmailAddress &&
              address == other.address;

  @override
  int get hashCode => address.hashCode;

  @override
  String toString() {
    return 'EmailAddress{address: $address}';
  }
}

void exercisePuttingItAllTogether() {
  var input = [
    'ali@gmail.com',
    'bobgmail.com',
    'cal@gmail.com',
  ];

  Iterable<EmailAddress> emailsList = parseEmailAddresses(input);

  print(anyInvalidEmailAddress(emailsList));
  print(validEmailAddresses(emailsList));
}

/*
  https://dart.dev/codelabs/async-await#example-introducing-futures
*/
Future<void> fetchUserOrder() {
  // Imagine that this function is fetching user info from another service or database.
  return Future.delayed(Duration(seconds: 2), () => print('Large Latte'));
}

void introducingFutures() {
  fetchUserOrder();
  print('Fetching user order...');
}

/*
  https://dart.dev/codelabs/async-await#example-completing-with-an-error
*/
Future<void> fetchUserOrderError() {
// Imagine that this function is fetching user info but encounters a bug
  return Future.delayed(
    Duration(seconds: 2),
    () => throw Exception('Logout failed: user ID is invalid')
  );
}

void completingFutureWithAnError() {
  fetchUserOrderError();
  print('Fetching user order...');
}

/*
  https://dart.dev/codelabs/async-await#example-execution-within-async-functions
*/
Future<void> printOrderMessage() async {
  print('Awaiting user order...');
  var order = await fetchUserOrderExecution();
  print('Your order is: $order');
}

Future<String> fetchUserOrderExecution() {
  // Imagine that this function is more complex and slow.
  return Future.delayed(Duration(seconds: 4), () => 'Large Latte');
}

Future<void> executionWithinAsyncFunctions() async { // main
  countSeconds(4);
  await printOrderMessage();
}

// You can ignore this function - it's here to visualize delay time in this example.
void countSeconds(int s) {
  for (var i = 1; i <= s; i++) {
    Future.delayed(Duration(seconds: i), () => print(i));
  }
}

/*
  https://dart.dev/codelabs/async-await#exercise-practice-using-async-and-await
*/
const role = 'administrator';
const oneSecond = Duration(seconds: 1);

Future<String> fetchRole() => Future.delayed(oneSecond, () => role);

Future<String> reportUserRole() async {
  String username = await fetchRole();

  return 'User role: $username';
}

const logins = 42;
Future<int> fetchLoginAmount() => Future.delayed(oneSecond, () => logins);

Future<String> reportLogins() async {
  int logins = await fetchLoginAmount();

  return 'Total number of logins: $logins';
}

void practiceUsingAsyncAndAwait() async {
  print(await reportUserRole());
  print(await reportLogins());
}

/*
  https://dart.dev/codelabs/async-await#handling-errors
*/
Future<void> printOrderMessageHandlingError() async {
  try {
    var order = await fetchUserOrderHandlingError();
    print('Awaiting user order...');
    print(order);
  } catch (err) {
    print('Caught error: $err');
  }
}

Future<String> fetchUserOrderHandlingError() {
  // Imagine that this function is more complex.
  var str = Future.delayed(
      Duration(seconds: 4),
      () => throw 'Cannot locate user order');
  return str;
}

void handlingFutureErrors () async {
  await printOrderMessageHandlingError();
}

/*
  https://dart.dev/codelabs/async-await#exercise-practice-handling-errors
*/
class UserError implements Exception {
  String errMsg() => 'New username is invalid';
}

Future fetchNewUsername() {
  var str = Future.delayed(oneSecond, () => throw UserError());
  return str;
}

// Implement changeUsername here
Future<String> changeUsername() async {
  try {
    return await fetchNewUsername();
  } catch (error) {
    return error.toString();
  }
}

void practiceHandlingFutureErrors() async {
  print(await changeUsername());
}

/*
  https://dart.dev/codelabs/async-await#exercise-putting-it-all-together
*/
bool logoutSucceeds = false;

Future<String> fetchUsername() => Future.delayed(oneSecond, () => 'Jean');
String failOnce () {
  if (logoutSucceeds) {
    return 'Success!';
  } else {
    logoutSucceeds = true;
    throw Exception('Logout failed');
  }
}

logoutUser() => Future.delayed(oneSecond, failOnce);

// Part 1
String addHello(user) => 'Hello $user';

// Part 2
// You can call the provided async function fetchUsername()
// to return the username.
Future<String> greetUser() async {
  var userName = await fetchUsername();
  return addHello(userName);
}

// Part 3
// You can call the provided async function logoutUser()
// to log out the user.
Future<String> sayGoodbye() async {
  try {
    var msg = await logoutUser();
    return '$msg Thanks, see you next time';
  } catch (e) {
    return 'Faile: $e';
  }
}

void futurePuttingItAllTogether() async {
  print(await greetUser());
  print(await sayGoodbye()); // fail
  print(await sayGoodbye()); // success
}

/*
  https://dart.dev/codelabs/null-safety#exercise-nullable-types
*/
void nonNullableTypes() {
  int? a;
  a = null;
  print('a is $a.');
}

/*
  https://dart.dev/codelabs/null-safety#exercise-nullable-type-parameters-for-generics
*/
void nullableTypeParametersForGenerics() {
  List<String> aListOfStrings = ['one', 'two', 'three'];
  List<String>? aNullableListOfStrings;
  List<String?> aListOfNullableStrings = ['one', null, 'three'];

  print('aListOfStrings is $aListOfStrings.');
  print('aNullableListOfStrings is $aNullableListOfStrings.');
  print('aListOfNullableStrings is $aListOfNullableStrings.');
}

/*
  https://dart.dev/codelabs/null-safety#exercise-null-assertion
*/
int? couldReturnNullButDoesnt() => -3;

void nullAssertion() {
  int? couldBeNullButIsnt = 1;
  List<int?> listThatCouldHoldNulls = [2, null, 4];

  int a = couldBeNullButIsnt;
  int b = listThatCouldHoldNulls.first!; // first item in the list
  int c = couldReturnNullButDoesnt()!.abs(); // absolute value

  print('a is $a.');
  print('b is $b.');
  print('c is $c.');
}

/*
  https://dart.dev/codelabs/null-safety#exercise-definite-assignment
*/
void definiteAssignment() {
  String text;

  if (DateTime.now().hour < 12) {
   text = "It's morning! Let's make aloo paratha!";
  } else {
    text = "It's afternoon! Let's make biryani!";
  }

  print(text);
  print(text.length);
}

/*
  https://dart.dev/codelabs/null-safety#exercise-null-checking
*/
int getLength(String? str) {
  // Add null check here
  str ??= '';

  return str.length;
}

void nullChecking() {
  print(getLength('This is a string!'));
}

/*
  https://dart.dev/codelabs/null-safety#exercise-promotion-with-exceptions
*/
int getLengthWithExceptions(String? str) {
  // Try throwing an exception here if `str` is null.
  return str == null ? throw Exception('str is null') : str.length;
}

void promotionWithExceptions() {
  print(getLengthWithExceptions('str is not null'));
  print(getLengthWithExceptions(null));
}

/*
  https://dart.dev/codelabs/null-safety#exercise-using-late
*/
class Meal {
  late String _description;

  void set description(String str) {
    _description = str;
  }

  String get description => _description;
}

void usingLate() {
  final myMeal = Meal();
  myMeal.description = 'Feijoada!';
  print(myMeal.description);
}

/*
  https://dart.dev/codelabs/null-safety#exercise-late-circular-references
*/
class Team {
  late final Coach coach;
}

class Coach {
  late final Team team;
}

void lateCircularReferences() {
  final myTeam = Team();
  final myCoach = Coach();
  myTeam.coach = myCoach;
  myCoach.team = myTeam;

  print('All done!');
}

/*
  https://dart.dev/codelabs/null-safety#exercise-late-and-lazy
*/
int _computeValue() {
  print('In _computeValue...');
  return 3;
}

class CachedValueProvider {
  late final _cache = _computeValue();
  int get value => _cache;
}

void lateAndLazy() {
  print('Calling constructor...');
  var provider = CachedValueProvider();
  print('Getting value...');
  print('The value is ${provider.value}!');
}

/*
  https://dart.dev/guides/language/extension-methods#using-extension-methods
*/
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
}

void extensionMethods() {
  print('42'.padLeft(5)); // Use a String method.
  print('42'.parseInt()); // Use an extension method.
}

/*
  https://dart.dev/guides/language/extension-methods#static-types-and-dynamic
*/
void staticTypesAndDynamic() {
  var v = '2';
  print(v.parseInt()); // Output: 2

  dynamic d = '2';
  print(d.parseInt()); // Runtime exception: NoSuchMethodError
}

/*
  https://dart.dev/guides/language/extension-methods#implementing-extension-methods
*/
extension NumberParsing2 on String {
  int parseInt2() {
    return int.parse(this);
  }

  double parseDouble2() {
    return double.parse(this);
  }
}

void implementingExtensionMethods() {
  print('23'.parseInt2());
  print('23.5'.parseDouble2());
}

/*
  https://dart.dev/guides/language/extension-methods#implementing-generic-extensions
*/
extension MyFancyList<T> on List<T> {
  int get doubleLength => length * 2;
  List<T> operator -() => reversed.toList();
  List<List<T>> split(int at) => [sublist(0, at), sublist(at)];
}

void implementingGenericExtensions() {
  List<String> stringList = ['abc', 'def', 'ghi'];
  
  print(stringList.doubleLength);
  print(-stringList);
  print(stringList.split(2));
}

/*
  https://dart.dev/guides/language/numbers#precision
*/
void precision() {
  print(pow(2, 53)); // native: 9007199254740992
  print(pow(2, 53)); // web: 9007199254740992

  print(pow(2, 63)); // native: 9007199254740992
  print(pow(2, 63)); // != web: 9223372036854776000
}

/*
  https://dart.dev/guides/language/numbers#identity
*/
void identity() {
  print(1.0 == 1); // native: true, web: true
  print(identical(1.0, 1)); // native: false, web: true
}

/*
  https://dart.dev/guides/language/numbers#types-and-type-checking
*/
void typesAndTypeChecking() {
  print(1 is int); // native: true, web: true
  print(1 is double); // native: false, web true
}

/*
  https://dart.dev/guides/language/numbers#bitwise-operations
*/

void bitwiseOperations() {
  print(-1 >> 0); // native: -1, web: 4294967295
  print(-1 ^ 2); // native: -3, web: 4294967293
}

/*
  https://dart.dev/guides/language/numbers#string-representation
*/
void stringRepresentation() {
  print(1.toString()); // native: "1", web: "1"
  print(1.0.toString()); // native: "1.0", web: "1"
}

/*
  https://dart.dev/guides/language/language-tour#variables
*/
void variables() {
  var nameVar = 'Bob';
  print(nameVar);

  Object nameObj = 'Bob';
  print(nameObj);

  String nameString = 'Bob';
  print(nameString);
}

/*
  https://dart.dev/guides/language/language-tour#default-value
*/
void defaultValue() {
  int? lineCount;
  assert(lineCount == null);

  int lineCountWithoutDefault;
  bool weLikeToCount = false;

  if (weLikeToCount) {
    lineCountWithoutDefault = 10;
  } else {
    lineCountWithoutDefault = 0;
  }

  print(lineCountWithoutDefault);
}

/*
  https://dart.dev/guides/language/language-tour#late-variables
*/
late String description;

String _readThermometer() {
  return 'expensive function';
}

void lateVariables() {
  description = 'Feijoada!';
  print(description);

  // This is the program's only call to _readThermometer().
  late String temperature = _readThermometer(); // Lazily initialized.
}

/*
  https://dart.dev/guides/language/language-tour#final-and-const
*/
void finalAndConst() {
  const Object i = 3; // Where i is a const Object with an int value...
  print(i);

  const list = [i as int]; // Use a typecast.
  print(list);

  const map = {if (i is int) i: 'int'}; // Use is and collection if.
  print(map);

  const set = {if (list is List<int>) ...list}; // ...and a spread.
  print(set);
}

/*
  https://dart.dev/guides/language/language-tour#numbers
*/

void numbers() {
  var x = 1;
  print(x);

  var hex = 0xDEADBEEF;
  print(hex);

  var exponent = 8e5;
  print(exponent);

  print(3 << 1);
  assert((3 << 1) == 6); // 0011 << 1 == 0110

  print(3 >> 1);
  assert((3 >> 1) == 1); // 0011 >> 1 == 0001

  print(3 | 4);
  assert((3 | 4) == 7); // 0011 | 0100 == 0111
}

/*
  https://dart.dev/guides/language/language-tour#strings
*/
void fff() {
  var s = 'string interpolation';

  assert('Dart has $s, which is very handy.' ==
      'Dart has string interpolation, ' +
          'which is very handy.');
  assert('That deserves all caps. ' +
          '${s.toUpperCase()} is very handy!' ==
      'That deserves all caps. ' +
          'STRING INTERPOLATION is very handy!');

  var s1 = 'String '
    'concatenation'
    " works even over line breaks.";

  var s2 = """This is also a
    multi-line string.""";

  // These work in a const string.
  const aConstNum = 0;
  const aConstBool = true;
  const aConstString = 'a constant string';

  // These do NOT work in a const string.
  var aNum = 0;
  var aBool = true;
  var aString = 'a string';
  const aConstList = [1, 2, 3];

  const validConstString = '$aConstNum $aConstBool $aConstString';
  // const invalidConstString = '$aNum $aBool $aString $aConstList';
}

/*
  https://dart.dev/guides/language/language-tour#booleans
*/
void booleans() {
  // Check for an empty string.
  var fullName = '';
  assert(fullName.isEmpty);

  // Check for zero.
  var hitPoints = 0;
  assert(hitPoints <= 0);

  // Check for null.
  var unicorn;
  assert(unicorn == null);

  // Check for NaN.
  var iMeantToDoThis = 0 / 0;
  assert(iMeantToDoThis.isNaN);
}

/*
  https://dart.dev/guides/language/language-tour#lists
*/
void lists() {
  var spreadOperatorList = [1, 2, 3];
  var spreadOperatorList2 = [0, ...spreadOperatorList];
  assert(spreadOperatorList2.length == 4);

  var nullAwareSpreadOperatorList;
  var nullAwareSpreadOperatorList2 = [0, ...?nullAwareSpreadOperatorList];
  assert(nullAwareSpreadOperatorList2.length == 1);

  var promoActive = true;

  var collectionIfList = [
    'Home',
    'Furniture',
    'Plants',
    if (promoActive) 'Outlet'
  ];
  assert(collectionIfList.length == 3);

  var collectionForListOfInts = [1, 2, 3];
  var collectionForListOfStrings = [
    '#0',
    for (var i in collectionForListOfInts) '#$i'
  ];
  assert(collectionForListOfStrings[1] == '#1');
}

/*
  https://dart.dev/guides/language/language-tour#sets
*/
void sets() {
  var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'}; // Set<String>

  var names = <String>{};
  // Set<String> names = {}; // This works, too.
  // var names = {}; // Creates a map, not a set.

  var elements = <String>{};
  elements.add('fluorine');
  elements.addAll(halogens);
  assert(elements.length == 5);

  final constantSet = const {
    'fluorine',
    'chlorine',
    'bromine',
    'iodine',
    'astatine',
  };
  // constantSet.add('helium'); // This line will cause an error.
}

/*
  https://dart.dev/guides/language/language-tour#maps
*/
void maps() {
  var gifts = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  };

  var nobleGases = {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };

  var giftsExplicit = Map<String, String>();
  gifts['first'] = 'partridge';
  gifts['second'] = 'turtledoves';
  gifts['fifth'] = 'golden rings';

  var nobleGasesExplicit = Map<int, String>();
  nobleGases[2] = 'helium';
  nobleGases[10] = 'neon';
  nobleGases[18] = 'argon';

  final constantMap = const {
    2: 'helium',
    10: 'neon',
    18: 'argon',
  };
}

/*
  https://dart.dev/guides/language/language-tour#runes-and-grapheme-clusters
*/
void runesAndGraphemeClusters() {
  var hi = 'Hi 🇩🇰';
  print(hi);
  print('The end of the string: ${hi.substring(hi.length - 1)}');
  print('The last character: ${hi.characters.last}\n');
}

/*
  https://dart.dev/guides/language/language-tour#symbols
*/
void symbols() {
  print(#radix);
  print(#bar);
}

/*
  https://dart.dev/guides/language/language-tour#parameters
*/
void parameters() {
  // not required named parameters
  void enableFlags({bool? bold, bool? hidden}) => print('$bool, $hidden');
  enableFlags(bold: true, hidden: false);
  // Tip: If a parameter is optional but can’t be null, provide a default value.

  // optional positional parameters
  String say(String from, String msg, [String? device]) {
    var result = '$from says $msg';

    if (device != null) {
      result = '$result with a $device';
    }
      return result;
  }

  assert(say('Bob', 'Howdy') == 'Bob says Howdy');
  assert(say('Bob', 'Howdy', 'smoke signal') == 'Bob says Howdy with a smoke signal');

  // default parameters
  // Sets the [bold] and [hidden] flags ...
  void enableFlagsWithDefaultParameters({bool bold = false, bool hidden = false}) => print('$bold, $hidden');

  // bold will be true; hidden will be false.
  enableFlagsWithDefaultParameters(bold: true);

  String sayWithDefaultParameters(String from, String msg, [String device = 'carrier pigeon']) {
    var result = '$from says $msg with a $device';

    return result;
  }

  assert(sayWithDefaultParameters('Bob', 'Howdy') == 'Bob says Howdy with a carrier pigeon');

  // Lists default parameters
  void doStuff(
    {List<int> list = const [1, 2, 3],
    Map<String, String> gifts = const {
      'first': 'paper',
      'second': 'cotton',
      'third': 'leather'
    }}) {
    print('list:  $list');
    print('gifts: $gifts');
  }

  doStuff();
}

/*
  https://dart.dev/guides/language/language-tour#functions-as-first-class-objects
*/
void functionsAsFirstClassObjects() {
  void printElement(int element) {
    print(element);
  }

  var list = [1, 2, 3];

  // Pass printElement as a parameter.
  list.forEach(printElement);

  // function to a variable
  var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
  assert(loudify('hello') == '!!! HELLO !!!');
}

/*
  https://dart.dev/guides/language/language-tour#anonymous-functions
*/
void anonymousFunctions() {
  const list = ['apples', 'bananas', 'oranges'];

  list.forEach((item) {
    print('${list.indexOf(item)}: $item');
  });
  // or
  list.forEach((item) => print('${list.indexOf(item)}: $item'));
}

/*
  https://dart.dev/guides/language/language-tour#lexical-scope
*/
bool topLevel = true;

void lexicalScope() {
    var insideMain = true;

  void myFunction() {
    var insideFunction = true;

    void nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}

/*
  https://dart.dev/guides/language/language-tour#lexical-closures
*/
void lexicalClosures() {
  Function makeAdder(int addBy) {
    return (int i) => addBy + i;
  }

  // Create a function that adds 2.
  var add2 = makeAdder(2);

  // Create a function that adds 4.
  var add4 = makeAdder(4);

  assert(add2(3) == 5);
  assert(add4(3) == 7);
}

/*
  https://dart.dev/guides/language/language-tour#testing-functions-for-equality
*/
void foo() {} // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
}

void testingFunctionsForEquality() {
  Function x;

  // Comparing top-level functions.
  x = foo;
  assert(foo == x);

  // Comparing static methods.
  x = A.bar;
  assert(A.bar == x);

  // Comparing instance methods.
  var v = A(); // Instance #1 of A
  var w = A(); // Instance #2 of A
  var y = w;
  x = w.baz;

  // These closures refer to the same instance (#2),
  // so they're equal.
  assert(y.baz == x);

  // These closures refer to different instances,
  // so they're unequal.
  assert(v.baz != w.baz);
}

/*
  https://dart.dev/guides/language/language-tour#return-values
*/
void returnValues() {
  foo() {}

  // If no return value is specified, the statement return null
  assert(foo() == null);
}

/*
  https://dart.dev/guides/language/language-tour#operators
*/
void operators() {
  /*
    a++
    a + b
    a = b
    a == b
    c ? a : b
    a is T

    // Parentheses improve readability.
    if ((n % i == 0) && (d % i == 0)) ...

    // Harder to read, but equivalent.
    if (n % i == 0 && d % i == 0) ...
  */
}

// https://dart.dev/guides/language/language-tour#arithmetic-operators
void arithmeticOperators() {
  assert(2 + 3 == 5);
  assert(2 - 3 == -1);
  assert(2 * 3 == 6);
  assert(5 / 2 == 2.5); // Result is a double
  assert(5 ~/ 2 == 2); // Result is an int
  assert(5 % 2 == 1); // Remainder

  assert('5/2 = ${5 ~/ 2} r ${5 % 2}' == '5/2 = 2 r 1');

  // prefix and postfix
  var a, b;

  a = 0;
  b = ++a; // Increment a before b gets its value.
  assert(a == b); // 1 == 1

  a = 0;
  b = a++; // Increment a AFTER b gets its value.
  assert(a != b); // 1 != 0

  a = 0;
  b = --a; // Decrement a before b gets its value.
  assert(a == b); // -1 == -1

  a = 0;
  b = a--; // Decrement a AFTER b gets its value.
  assert(a != b); // -1 != 0
}

// https://dart.dev/guides/language/language-tour#equality-and-relational-operators
void equalityAndRelationalOperators() {
  assert(2 == 2);
  assert(2 != 3);
  assert(3 > 2);
  assert(2 < 3);
  assert(3 >= 3);
  assert(2 <= 3);
}

// https://dart.dev/guides/language/language-tour#type-test-operators
class PersonTypeCastExample{
  String? firstName;

  PersonTypeCastExample({ this.firstName, });
}

void typeTestOperators() {
  var employee;

  // sure
  (employee as PersonTypeCastExample).firstName = 'Bob';

  // NOT sure
  if (employee is Person) {
    employee.firstName = 'Bob';
  }
}

// https://dart.dev/guides/language/language-tour#assignment-operators
void assignmentOperators(value) {
  var a;
  var  b;
  // Assign value to a
  a = value;
  // Assign value to b if b is null; otherwise, b stays the same
  b ??= value;

  a = 2; // Assign using =
  a *= 3; // Assign and multiply: a = a * 3
  assert(a == 6);
  print('$a, $b');
}

// https://dart.dev/guides/language/language-tour#logical-operators
void logicalOperators() {
  var done;
  var col;

  if (!done && (col == 0 || col == 3)) {
    // ...Do something...
  }
}

// https://dart.dev/guides/language/language-tour#bitwise-and-shift-operators
void bitwiseAndShiftOperators() {
  final value = 0x22;
  final bitmask = 0x0f;

  assert((value & bitmask) == 0x02); // AND
  assert((value & ~bitmask) == 0x20); // AND NOT
  assert((value | bitmask) == 0x2f); // OR
  assert((value ^ bitmask) == 0x2d); // XOR
  assert((value << 4) == 0x220); // Shift left
  assert((value >> 4) == 0x02); // Shift right
}

// https://dart.dev/guides/language/language-tour#conditional-expressions
void conditionalExpressions(bool isPublic) {
  var visibility = isPublic ? 'public' : 'private';

  String playerNameNullishCoalescing(String? name) => name ?? 'Guest';

  // Slightly longer version uses ?: operator.
  String playerNameWithTernary(String? name) => name != null ? name : 'Guest';

  // Very long version uses if-else statement.
  String playerNameWithIfElse(String? name) {
    if (name != null) {
      return name;
    } else {
      return 'Guest';
    }
  }
}

// https://dart.dev/guides/language/language-tour#cascade-notation
class Paint {
  String color = '';
  int strokeCap = 0;
  double strokeWidth = 0.0;
}

class Colors {
  static String black = '000000';
}

class StrokeCap {
  static int round = 1;
}

void cascadeNotation() {
  var paint = Paint()
  ..color = Colors.black
  ..strokeCap = StrokeCap.round
  ..strokeWidth = 5.0;

  print(paint.color);

  // null-shorting cascade

  // querySelector('#confirm') // Get an object.
  // ?..text = 'Confirm' // Use its members.
  // ..classes.add('important')
  // ..onClick.listen((e) => window.alert('Confirmed!'));

  // nest cascade

  // final addressBook = (AddressBookBuilder()
  //     ..name = 'jenny'
  //     ..email = 'jenny@example.com'
  //     ..phone = (PhoneNumberBuilder()
  //           ..number = '415-555-0100'
  //           ..label = 'home')
  //         .build())
  //   .build();
}

// https://dart.dev/guides/language/language-tour#if-and-else
bool isRaining() => true;
bool isSnowing() => true;

class Cloth {
  void bringRainCoat() => print('bringRainCoat');
  void wearJacket() => print('wearJacket');
}

class CarAccesories {
  void putTopDown() => print('putTopDown');
}

Cloth you = new Cloth();
CarAccesories car = new CarAccesories();

void ifAndElse() {
  if (isRaining()) {
    you.bringRainCoat();
  } else if (isSnowing()) {
    you.wearJacket();
  } else {
    car.putTopDown();
  }
}

// https://dart.dev/guides/language/language-tour#for-loops
class Candidate {
  void interview() => print('interview');
  int yearsExperience = 4;
}

void forLoops() {
  var message = StringBuffer('Dart is fun');
  for (var i = 0; i < 5; i++) {
    message.write('!');
  }

  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    callbacks.add(() => print(i));
  }
  callbacks.forEach((c) => c());

  Candidate c1 = new Candidate();
  List<Candidate> candidates = [c1];
  for (var candidate in candidates) {
    candidate.interview();
  }

  var collection = [1, 2, 3];
  collection.forEach(print); // 1 2 3
}

// https://dart.dev/guides/language/language-tour#while-and-do-while
bool isDone() => true;
void doSomething() => print('doSomething');
void printLine() => print('line');
bool atEndOfPage() => true;

void whileDoWhile() {
  while (!isDone()) {
    doSomething();
  }

  do {
    printLine();
  } while (!atEndOfPage());
}

// https://dart.dev/guides/language/language-tour#break-and-continue
bool shutDownRequested() => true;
void processIncomingRequests() => print('processIncomingRequests');

void breakAndContinue() {
  while (true) {
    if (shutDownRequested()) break;
    processIncomingRequests();
  }

  Candidate c1 = new Candidate();
  List<Candidate> candidates = [c1];
  for (int i = 0; i < candidates.length; i++) {
    var candidate = candidates[i];
    if (candidate.yearsExperience < 5) {
      continue;
    }
    candidate.interview();
  }

  // iterable or set
  candidates
    .where((c) => c.yearsExperience >= 5)
    .forEach((c) => c.interview());
}

// https://dart.dev/guides/language/language-tour#switch-and-case
void switchCase() {
  var command = 'OPEN';
  switch (command) {
    case 'CLOSED':
      // executeClosed();
      break;
    case 'PENDING':
      // executePending();
      break;
    case 'APPROVED':
      // executeApproved();
      break;
    case 'DENIED':
      // executeDenied();
      break;
    case 'OPEN':
      // executeOpen();
      break;
    default:
      // executeUnknown();
  }

  command = 'CLOSED';
  switch (command) {
    case 'CLOSED': // Empty case falls through.
    case 'NOW_CLOSED':
      // Runs for both CLOSED and NOW_CLOSED.
      // executeNowClosed();
      break;
  }

  command = 'CLOSED';
  switch (command) {
    case 'CLOSED':
      // executeClosed();
      continue nowClosed;
    // Continues executing at the nowClosed label.

    nowClosed:
    case 'NOW_CLOSED':
      // Runs for both CLOSED and NOW_CLOSED.
      // executeNowClosed();
      break;
  }
}

// https://dart.dev/guides/language/language-tour#assert
void assertsExample() {
  // Make sure the variable has a non-null value.
  String ?text;
  assert(text != null, text);

  // Make sure the value is less than 100.
  int number = 10;
  assert(number < 100, number);

  // Make sure this is an https URL.
  String urlString = 'https://dart.dev/guides/language/language-tour#assert';
  assert(urlString.startsWith('https'), urlString);

  assert(urlString.startsWith('https'), 'URL ($urlString) should start with "https".');
}

// https://dart.dev/guides/language/language-tour#throw
void throwExamples() {
  throw FormatException('Expected at least 1 section');
  // throw 'Out of llamas!';
}

// https://dart.dev/guides/language/language-tour#catch
void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // Runtime error
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    rethrow; // Allow callers to see the exception.
  }
}

void catchExample() {
  /*
    try {
      breedMoreLlamas();
    } on OutOfLlamasException {
      // A specific exception
      buyMoreLlamas();
    } on Exception catch (e) {
      // Anything else that is an exception
      print('Unknown exception: $e');
    } catch (e) {
      // No specified type, handles all
      print('Something really unknown: $e');
    }
  */

  try {
    // ···
  } on Exception catch (e) {
    print('Exception details:\n $e');
  } catch (e, s) {
    print('Exception details:\n $e');
    print('Stack trace:\n $s');
  }

  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}

// https://dart.dev/guides/language/language-tour#finally
void finallyExample() {
  try {
    // breedMoreLlamas();
  } catch (e) {
    // print('Error: $e'); // Handle the exception first.
  } finally {
    // cleanLlamaStalls(); // Then clean up.
  }
}

// https://dart.dev/guides/language/language-tour#using-class-members
void usingClassMembers() {
  var p = Point(2, 2);

  // Get the value of y.
  assert(p.y == 2);

  // Invoke distanceTo() on p.
  // double distance = p.distanceTo(Point(4, 4));

  // If p is non-null, set a variable equal to its y value.
  var a = p?.y;
}

// https://dart.dev/guides/language/language-tour#using-constructors
void constructors() {
  /*
  var p1 = new Point(2, 2);
  var p2 = new Point.fromJson({'x': 1, 'y': 2});

  // Only one const, which establishes the constant context.
  const pointAndLine = {
    'point': [ImmutablePoint(0, 0)],
    'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
  };

  var a = const ImmutablePoint(1, 1); // Creates a constant
  var b = ImmutablePoint(1, 1); // Does NOT create a constant

  assert(!identical(a, b)); // NOT the same instance!
  */
}

// https://dart.dev/guides/language/language-tour#instance-variables
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}

void instanceVariables() {
  /*
    class Point {
      double? x; // Declare instance variable x, initially null.
      double? y; // Declare y, initially null.
      double z = 0; // Declare z, initially 0.
    }
  */

  ProfileMark withoutName = ProfileMark.unnamed();
  ProfileMark withName = ProfileMark('profile');
}

// https://dart.dev/guides/language/language-tour#constructors
class Point {
  double x = 0;
  double y = 0;

  Point(double x, double y) {
    // There's a better way to do this, stay tuned.
    this.x = x;
    this.y = y;
  }
}

class Point2 {
  double x = 0;
  double y = 0;

  // Syntactic sugar for setting x and y
  // before the constructor body runs.
  Point2(this.x, this.y);
}

const double xOrigin = 0;
const double yOrigin = 0;

class PointNamed {
  double x = 0;
  double y = 0;

  PointNamed(this.x, this.y);

  // Named constructor
  PointNamed.origin()
      : x = xOrigin,
        y = yOrigin;
}

class PersonSuper {
  String? firstName;

  PersonSuper.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends PersonSuper {
  // PersonSuper does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}

class LoggerFactory {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, LoggerFactory> _cache =
      <String, LoggerFactory>{};

  factory LoggerFactory(String name) {
    return _cache.putIfAbsent(
        name, () => LoggerFactory._internal(name));
  }

  factory LoggerFactory.fromJson(Map<String, Object> json) {
    return LoggerFactory(json['name'].toString());
  }

  LoggerFactory._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}

void constructorsExample() {
  var logger = LoggerFactory('UI');
  logger.log('Button clicked');

  var logMap = {'name': 'UI'};
  var loggerJson = LoggerFactory.fromJson(logMap);
}

// https://dart.dev/guides/language/language-tour#methods
class PointInstanceExample {
  double x = 0;
  double y = 0;

  PointInstanceExample(this.x, this.y);

  double distanceTo(PointInstanceExample other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

// Operators
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  // Operator == and hashCode not shown.
  // ···
}

// getters and setters
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Define two calculated properties: right and bottom.
  double get right => left + width;
  set right(double value) => left = value - width;
  
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

// Abstract methods
abstract class Doer {
  // Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}

void methodsExample() {
  // Operators
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));

  // getters and setters
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}

// https://dart.dev/guides/language/language-tour#abstract-classes
// This class is declared abstract and thus
// can't be instantiated.
abstract class AbstractContainer {
  // Define constructors, fields, methods...

  void updateChildren(); // Abstract method.
}

// https://dart.dev/guides/language/language-tour#implicit-interfaces
// A person. The implicit interface contains greet().
class PersonImplicitInterface {
  // In the interface, but visible only in this library.
  final String _name;

  // Not in the interface, since this is a constructor.
  PersonImplicitInterface(this._name);

  // In the interface.
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class ImpostorImplicitInterface implements PersonImplicitInterface {
  String get _name => '';

  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(PersonImplicitInterface person) => person.greet('Bob');

void implicitInterface() {
  print(greetBob(PersonImplicitInterface('Kathy')));
  print(greetBob(ImpostorImplicitInterface()));
}

// https://dart.dev/guides/language/language-tour#extending-a-class
class Television {
  void _illuminateDisplay() => print('_illuminateDisplay');
  void _activateIrSensor() => print('_activateIrSensor');

  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
}

class SmartTelevision extends Television {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }

  void _bootNetworkInterface() => print('_bootNetworkInterface');
  void _initializeMemory() => print('_initializeMemory');
  void _upgradeApps() => print('_upgradeApps');
}

// Overriding members
class SmartTelevisionOverride extends Television {
  @override
  void turnOn() => print('override turn on');
}

// noSuchMethod()
class AWithNoSuchMethod {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: '
        '${invocation.memberName}');
  }
}

// https://dart.dev/guides/language/language-tour#extension-methods
// import 'string_apis.dart';

// print('42'.padLeft(5)); // Use a String method.
// print('42'.parseInt()); // Use an extension method.

// https://dart.dev/guides/language/language-tour#enumerated-types
enum ColorEnums { red, green, blue }

void enumeratedTypes() {
  assert(ColorEnums.red.index == 0);
  assert(ColorEnums.green.index == 1);
  assert(ColorEnums.blue.index == 2);

  List<ColorEnums> colors = ColorEnums.values;
  assert(colors[2] == ColorEnums.blue);

  var aColor = ColorEnums.blue;

  switch (aColor) {
    case ColorEnums.red:
      print('Red as roses!');
      break;
    case ColorEnums.green:
      print('Green as grass!');
      break;
    default: // Without this, you see a WARNING.
      print(aColor); // 'Color.blue'
  }
}

// https://dart.dev/guides/language/language-tour#adding-features-to-a-class-mixins
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

class Performer {

}

mixin Aggressive {

}

mixin Demented {
  
}

class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person
    with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}

mixin MusicalPerformer on Musician {
  // ...
}
class SingerDancer extends Musician with MusicalPerformer {
  // ...
}

void AddingFeaturesToAClassMixins() {
  // ...
}

// https://dart.dev/guides/language/language-tour#class-variables-and-methods
// Static variables
class Queue {
  static const initialCapacity = 16;
  // ···
}

void classVariablesAndMethods() {
  assert(Queue.initialCapacity == 16);
}

// Static methods
class PointStaticMethod {
  double x, y;
  PointStaticMethod(this.x, this.y);

  static double distanceBetween(PointStaticMethod a, PointStaticMethod b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

void staticMethod() {
  var a = PointStaticMethod(2, 2);
  var b = PointStaticMethod(4, 4);
  var distance = PointStaticMethod.distanceBetween(a, b);
  assert(2.8 < distance && distance < 2.9);
  print(distance);
}

// https://dart.dev/guides/language/language-tour#generics
abstract class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}

abstract class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}

abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}

void generics() {
  var names = <String>[];
  names.addAll(['Seth', 'Kathy', 'Lars']);
  // names.add(42); // Error
}

// https://dart.dev/guides/language/language-tour#using-collection-literals
void usingCollectionLiterals() {
  var names = <String>['Seth', 'Kathy', 'Lars'];
  var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
  var pages = <String, String>{
    'index.html': 'Homepage',
    'robots.txt': 'Hints for web robots',
    'humans.txt': 'We are people, not machines'
  };

  print(names);
  print(uniqueNames);
  print(pages);
}

// https://dart.dev/guides/language/language-tour#using-parameterized-types-with-constructors
class View {
  var position = 0;
}

void usingParameterizedTypesWithConstructors() {
  var names = ['a'];
  var nameSet = Set<String>.from(names);
  print(nameSet);

  var views = Map<int, View>();
  print(views);
}

// https://dart.dev/guides/language/language-tour#generic-collections-and-the-types-they-contain
void genericCollectionsAndTheTypesTheyContain() {
  var names = <String>[];
  names.addAll(['Seth', 'Kathy', 'Lars']);
  print(names is List<String>); // true
}

// https://dart.dev/guides/language/language-tour#restricting-the-parameterized-type
class SomeBaseClass {}

class Foo<T extends SomeBaseClass> {
  // Implementation goes here...
  String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {}

void restrictingTheParameterizedType() {
  var someBaseClassFoo = Foo<SomeBaseClass>();
  var extenderFoo = Foo<Extender>();

  var foo = Foo();
  print(foo); // Instance of 'Foo<SomeBaseClass>'
}

// https://dart.dev/guides/language/language-tour#using-generic-methods
T first<T>(List<T> ts) {
  // Do some initial work or error checking, then...
  T tmp = ts[0];
  // Do some additional checking or processing...
  return tmp;
}

void usingGenericMethods() {
  // ...
}

// https://dart.dev/guides/language/language-tour#using-libraries
void usingLibraries() {
  // Specifying a library prefix
  /*
    import 'package:lib1/lib1.dart';
    import 'package:lib2/lib2.dart' as lib2;

    // Uses Element from lib1.
    Element element1 = Element();

    // Uses Element from lib2.
    lib2.Element element2 = lib2.Element();
  */

  // Importing only part of a library
  /*
    // Import only foo.
    import 'package:lib1/lib1.dart' show foo;

    // Import all names EXCEPT foo.
    import 'package:lib2/lib2.dart' hide foo;
  */

  // Lazily loading a library
  /*
    import 'package:greetings/hello.dart' deferred as hello;

    Future<void> greet() async {
      await hello.loadLibrary();
      hello.printGreeting();
    }
  */
}

// https://dart.dev/guides/language/language-tour#asynchrony-support
Future<void> checkVersion() async {
  var version = await lookUpVersion();
  // Do something with version
}
void asynchronySupport() async {
  try {
    var version = await lookUpVersion();
  } catch (e) {
    // React to inability to look up the version
  }
}

// https://dart.dev/guides/language/language-tour#declaring-async-functions
Future<String> lookUpVersion() async => '1.0.0';

// https://dart.dev/guides/language/language-tour#handling-streams
void handlingStreams(Stream<String> requestServer) async {
  await for (var request in requestServer) {
    // Executes each time the stream emits a value.
    // handleRequest(request);
  }
}

// https://dart.dev/guides/language/language-tour#generators
// synchronous
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}

// asynchronous
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}

// recursive
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}

// https://dart.dev/guides/language/language-tour#callable-classes
class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

void callableClasses() {
  var wf = WannabeFunction();
  var out = wf('Hi', 'there,', 'gang');

  print(out);
}

// https://dart.dev/guides/language/language-tour#isolates
// see documentation

// https://dart.dev/guides/language/language-tour#typedefs
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void typefsExample() {
  /*
    typedef IntList = List<int>;
    IntList il = [1, 2, 3];

    typedef ListMapper<X> = Map<X, List<X>>;
    Map<String, List<String>> m1 = {}; // Verbose.
    ListMapper<String> m2 = {}; // Same thing but shorter and clearer.
  */

  assert(sort is Compare<int>); // True!
}

// https://dart.dev/guides/language/language-tour#metadata
class TelevisionWithMetadata {
  // Use [turnOn] to turn the power on instead.
  @Deprecated('Use turnOn instead')
  void activate() {
    turnOn();
  }

  // Turns the TV's power on.
  void turnOn() {}
}

// library todo;
class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}

void metadataExample() {
  @Todo('seth', 'make this do something')
  void doSomething() {
    print('do something');
  }
}

// https://dart.dev/guides/language/language-tour#single-line-comments
void singleLineComments() {
  // TODO: refactor into an AbstractLlamaGreetingFactory?
  print('Welcome to my Llama farm!');
}

// https://dart.dev/guides/language/language-tour#multi-line-comments
void multiLineComments() {
    /*
      * This is a lot of work. Consider raising chickens.

      Llama larry = Llama();
      larry.feed();
      larry.exercise();
      larry.clean();
   */
}

// https://dart.dev/guides/language/language-tour#documentation-comments
class Food {}
class Activity {}
/// A domesticated South American camelid (Lama glama).
///
/// Andean cultures have used llamas as meat and pack
/// animals since pre-Hispanic times.
///
/// Just like any other animal, llamas need to eat,
/// so don't forget to [feed] them some [Food].
class Llama {
  String? name;

  /// Feeds your llama [food].
  ///
  /// The typical llama eats one bale of hay per week.
  void feed(Food food) {
    // ...
  }

  /// Exercises your llama with an [activity] for
  /// [timeLimit] minutes.
  void exercise(Activity activity, int timeLimit) {
    // ...
  }
}

// https://dart.dev/guides/language/type-system
void printInts(List<int> a) => print(a);

void typeSystem() {
  var list = [];
  list.add(1);
  list.add('2');
  // printInts(list); // type error

  var intList = <int>[];
  intList.add(1);
  intList.add(2);
  printInts(intList);
}

// https://dart.dev/guides/language/type-system#what-is-soundness
// important to read!!

// https://dart.dev/guides/language/type-system#tips-for-passing-static-analysis
// important to read!!

// https://dart.dev/guides/language/type-system#use-sound-return-types-when-overriding-methods
class Animal {
  void chase(Animal a) {  }
  Animal get parent => this.parent;
}

class HoneyBadger extends Animal {
  @override
  void chase(Animal a) { }

  @override
  HoneyBadger get parent => this.parent;
}

class HoneyBadgerWRONG extends Animal {
  @override
  void chase(Animal a) { }
  
  // @override
  // Root get parent => this.parent; // error: root is not a subtype of Animal
}

// https://dart.dev/guides/language/type-system#use-sound-parameter-types-when-overriding-methods
class HoneyBadgerWithObjectChase extends Animal {
  @override
  void chase(Object a) { }

  @override
  Animal get parent => this.parent;
}

class Mouse extends Animal { }

class Cat extends Animal {
  // @override
  // void chase(Mouse x) { } // error: cat already extends Animal
}
/*
  Animal wrongCatInstance = Cat();
  wrongCatInstance.chase(Alligator()); // error: Not type safe or feline safe.
*/

// https://dart.dev/guides/language/type-system#dont-use-a-dynamic-list-as-a-typed-list
class Dog extends Animal {}
void dontUseADynamicListAsATypedList() {
  // List<Cat> foo = <dynamic>[Dog()]; // Error
  List<dynamic> bar = <dynamic>[Dog(), Cat()]; // OK
}

// https://dart.dev/guides/language/type-system#runtime-checks
void runtimeChecks() {
  List<Animal> animals = [Dog()];
  List<Cat> cats = animals as List<Cat>; // runtime error
}

// https://dart.dev/guides/language/type-system#type-inference
void typeInference() {
  Map<String, dynamic> argumentsExplicitType = {'argA': 'hello', 'argB': 42}; // explicit type
  var argumentsImplicitType = {'argA': 'hello', 'argB': 42}; // implicit Map<String, Object>

  print(argumentsExplicitType);
  print(argumentsImplicitType);
}

// https://dart.dev/guides/language/type-system#field-and-method-inference

// https://dart.dev/guides/language/type-system#static-field-inference

// https://dart.dev/guides/language/type-system#local-variable-inference
void localVariableInference() {
  var x = 3; // x is inferred as an int.
  // x = 4.0; // error

  num y = 3; // A num can be double or int.
  y = 4.0;
}

// https://dart.dev/guides/language/type-system#type-argument-inference
void typeArgumentInference() {
  // Inferred as if you wrote <int>[].
  List<int> listOfInt = [];

  // Inferred as if you wrote <double>[3.0].
  var listOfDouble = [3.0];

  // Inferred as Iterable<int>.
  var ints = listOfDouble.map((x) => x.toInt());
}

// https://dart.dev/guides/language/type-system#substituting-types

// https://dart.dev/guides/language/type-system#simple-type-assignment
class MaineCoon extends Cat {}

void simpleTypeAssignment() {
  Cat c = Cat();
  Animal c2 = Cat();
  // MaineCoon c3 = Cat(); // error
  Cat c4 = MaineCoon();
}

// https://dart.dev/guides/language/type-system#generic-type-assignment
void genericTypeAssignment() {
  List<Cat> myCats = <MaineCoon>[];
  // List<Cat> myCats = <Animal>[]; // error: Cat is a subtype of Animal
  // List<Cat> myCats = <Animal>[] as List<Cat>; // force generic type, bad!!
}

// https://dart.dev/guides/language/type-system#methods

// https://dart.dev/guides/libraries

// https://dart.dev/guides/libraries/library-tour

// https://dart.dev/guides/libraries/library-tour#dartcore---numbers-collections-strings-and-more

// https://dart.dev/guides/libraries/library-tour#printing-to-the-console
void printingToTheConsole() {
  var anObject = {'a': 1, 'b': 2}; 
  print(anObject);

  String tea = 'tea';
  print('I drink $tea.');
}

// https://dart.dev/guides/libraries/library-tour#numbers
void coreLibrariesNumbers() {
  assert(int.parse('42') == 42);
  assert(int.parse('0x42') == 66);
  assert(double.parse('0.50') == 0.5);

  assert(num.parse('42') is int);
  assert(num.parse('0x42') is int);
  assert(num.parse('0.50') is double);

  assert(int.parse('42', radix: 16) == 66);

  // Convert an int to a string.
  assert(42.toString() == '42');

  // Convert a double to a string.
  assert(123.456.toString() == '123.456');

  // Specify the number of digits after the decimal.
  assert(123.456.toStringAsFixed(2) == '123.46');

  // Specify the number of significant figures.
  assert(123.456.toStringAsPrecision(2) == '1.2e+2');
  assert(double.parse('1.2e+2') == 120.0);
}

// https://dart.dev/guides/libraries/library-tour#strings-and-regular-expressions
void searchingInsideAString() {
  // Check whether a string contains another string.
  assert('Never odd or even'.contains('odd'));

  // Does a string start with another string?
  assert('Never odd or even'.startsWith('Never'));

  // Does a string end with another string?
  assert('Never odd or even'.endsWith('even'));

  // Find the location of a string inside a string.
  assert('Never odd or even'.indexOf('odd') == 6);
}

void extractingDataFromAString() {
  // Grab a substring.
  assert('Never odd or even'.substring(6, 9) == 'odd');

  // Split a string using a string pattern.
  var parts = 'structured web apps'.split(' ');
  assert(parts.length == 3);
  assert(parts[0] == 'structured');

  // Get a UTF-16 code unit (as a string) by index.
  assert('Never odd or even'[0] == 'N');

  // Use split() with an empty string parameter to get
  // a list of all characters (as Strings); good for
  // iterating.
  for (var char in 'hello'.split('')) {
    print(char);
  }

  // Get all the UTF-16 code units in the string.
  var codeUnitList =
      'Never odd or even'.codeUnits.toList();
  assert(codeUnitList[0] == 78);
}

void convertingToUppercaseOrLowercase() {
  assert('structured web apps'.toUpperCase() == 'STRUCTURED WEB APPS');

  assert('STRUCTURED WEB APPS'.toLowerCase() == 'structured web apps');
}

void trimmingAndEmptyStrings() {
  // Trim a string.
  assert('  hello  '.trim() == 'hello');

  // Check whether a string is empty.
  assert(''.isEmpty);

  // Strings with only white space are not empty.
  assert('  '.isNotEmpty);
}

void replacingPartOfAString() {
  var greetingTemplate = 'Hello, NAME!';
  var greeting =
      greetingTemplate.replaceAll(RegExp('NAME'), 'Bob');

  // greetingTemplate didn't change.
  assert(greeting != greetingTemplate);
}

void buildingAString() {
  var sb = StringBuffer();
  sb
    ..write('Use a StringBuffer for ')
    ..writeAll(['efficient', 'string', 'creation'], ' ')
    ..write('.');

  var fullString = sb.toString();

  assert(fullString ==
      'Use a StringBuffer for efficient string creation.');
}

void regularExpressions() {
  // Here's a regular expression for one or more digits.
  var numbers = RegExp(r'\d+');

  var allCharacters = 'llamas live fifteen to twenty years';
  var someDigits = 'llamas live 15 to 20 years';

  // contains() can use a regular expression.
  assert(!allCharacters.contains(numbers));
  assert(someDigits.contains(numbers));

  // Replace every match with another string.
  var exedOut = someDigits.replaceAll(numbers, 'XX');
  assert(exedOut == 'llamas live XX to XX years');

  var numbers2 = RegExp(r'\d+');
  var someDigits2 = 'llamas live 15 to 20 years';

  // Check whether the reg exp has a match in a string.
  assert(numbers2.hasMatch(someDigits2));

  // Loop through all matches.
  for (var match in numbers.allMatches(someDigits2)) {
    print(match.group(0)); // 15, then 20
  }
}

// https://dart.dev/guides/libraries/library-tour#collections
// Lists
void listsExample() {
  // Create an empty list of strings.
  var grains = <String>[];
  assert(grains.isEmpty);

  // Create a list using a list literal.
  var fruits = ['apples', 'oranges'];

  // Add to a list.
  fruits.add('kiwis');

  // Add multiple items to a list.
  fruits.addAll(['grapes', 'bananas']);

  // Get the list length.
  assert(fruits.length == 5);

  // Remove a single item.
  var appleIndex = fruits.indexOf('apples');
  fruits.removeAt(appleIndex);
  assert(fruits.length == 4);

  // Remove all elements from a list.
  fruits.clear();
  assert(fruits.isEmpty);

  // You can also create a List using one of the constructors.
  var vegetables = List.filled(99, 'broccoli');
  assert(vegetables.every((v) => v == 'broccoli'));
}

void indexOfExample() {
  var fruits = ['apples', 'oranges'];

  // Access a list item by index.
  assert(fruits[0] == 'apples');

  // Find an item in a list.
  assert(fruits.indexOf('apples') == 0);
}

void sortExample() {
  var fruits = ['bananas', 'apples', 'oranges'];

  // Sort a list.
  fruits.sort((a, b) => a.compareTo(b));
  assert(fruits[0] == 'apples');

  // This list should contain only strings.
  var fruitsExplicit = <String>[];

  fruitsExplicit.add('apples');
  var fruit = fruitsExplicit[0];
  assert(fruit is String);

  // fruits.add(5); // Error: 'int' can't be assigned to 'String'
}

void setsExamples() {
  // Create an empty set of strings.
  var ingredients = <String>{};

  // Add new items to it.
  ingredients.addAll(['gold', 'titanium', 'xenon']);
  assert(ingredients.length == 3);

  // Adding a duplicate item has no effect.
  ingredients.add('gold');
  assert(ingredients.length == 3);

  // Remove an item from a set.
  ingredients.remove('gold');
  assert(ingredients.length == 2);

  // You can also create sets using
  // one of the constructors.
  var atomicNumbers = Set.from([79, 22, 54]);
}

void containsExamples() {
  var ingredients = Set<String>();
  ingredients.addAll(['gold', 'titanium', 'xenon']);

  // Check whether an item is in the set.
  assert(ingredients.contains('titanium'));

  // Check whether all the items are in the set.
  assert(ingredients.containsAll(['titanium', 'xenon']));
}

void intersectionExamples() {
  var ingredients = Set<String>();
  ingredients.addAll(['gold', 'titanium', 'xenon']);

  // Create the intersection of two sets.
  var nobleGases = Set.from(['xenon', 'argon']);
  var intersection = ingredients.intersection(nobleGases);
  assert(intersection.length == 1);
  assert(intersection.contains('xenon'));
}

void mapsExamples() {
  // Maps often use strings as keys.
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  // Maps can be built from a constructor.
  var searchTerms = Map();

  // Maps are parameterized types; you can specify what
  // types the key and value should be.
  var nobleGases = Map<int, String>();

  nobleGases = {54: 'xenon'};

  // Retrieve a value with a key.
  assert(nobleGases[54] == 'xenon');

  // Check whether a map contains a key.
  assert(nobleGases.containsKey(54));

  // Remove a key and its value.
  nobleGases.remove(54);
  assert(!nobleGases.containsKey(54));
}

void getMapsValuesOrKeys() {
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  // Get all the keys as an unordered collection
  // (an Iterable).
  var keys = hawaiianBeaches.keys;

  assert(keys.length == 3);
  assert(Set.from(keys).contains('Oahu'));

  // Get all the values as an unordered collection
  // (an Iterable of Lists).
  var values = hawaiianBeaches.values;
  assert(values.length == 3);
  assert(values.any((v) => v.contains('Waikiki')));
}

void mapsContainsKeysExamples() {
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  assert(hawaiianBeaches.containsKey('Oahu'));
  assert(!hawaiianBeaches.containsKey('Florida'));
}

void putIfAbsentExample() {
  String pickToughestKid() => 'string';

  var teamAssignments = <String, String>{};

  teamAssignments.putIfAbsent('Catcher', () => pickToughestKid());

  assert(teamAssignments['Carcher'] != null);
}

// Common collection methods
void isEmptyIsNotEmptyExamples() {
  var coffees = <String>[];
  var teas = ['green', 'black', 'chamomile', 'earl grey'];
  assert(coffees.isEmpty);
  assert(teas.isNotEmpty);
}

void forEachExamples() {
  var teas = ['green', 'black', 'chamomile', 'earl grey'];

  teas.forEach((tea) => print('I drink $tea'));

  var loudTeas = teas.map((tea) => tea.toUpperCase());
  loudTeas.forEach(print);

  loudTeas = teas.map((tea) => tea.toUpperCase()).toList();
}

void forEachWithMapsExample() {
  var hawaiianBeaches = {
    'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
    'Big Island': ['Wailea Bay', 'Pololu Beach'],
    'Kauai': ['Hanalei', 'Poipu']
  };

  hawaiianBeaches.forEach((k, v) {
    print('I want to visit $k and swim at $v');
    // I want to visit Oahu and swim at
    // [Waikiki, Kailua, Waimanalo], etc.
  });
}

void forEachWithWhere() {
  var teas = ['green', 'black', 'chamomile', 'earl grey'];

  // Chamomile is not caffeinated.
  bool isDecaffeinated(String teaName) =>
      teaName == 'chamomile';

  // Use where() to find only the items that return true
  // from the provided function.
  var decaffeinatedTeas =
      teas.where((tea) => isDecaffeinated(tea));
  // or teas.where(isDecaffeinated)

  // Use any() to check whether at least one item in the
  // collection satisfies a condition.
  assert(teas.any(isDecaffeinated));

  // Use every() to check whether all the items in a
  // collection satisfy a condition.
  assert(!teas.every(isDecaffeinated));
}

// https://dart.dev/guides/libraries/library-tour#uris
void encodingAndDecodingFullyQualifiedURIs() {
  var uri = 'https://example.org/api?foo=some message';

  var encoded = Uri.encodeFull(uri);
  assert(encoded ==
      'https://example.org/api?foo=some%20message');

  var decoded = Uri.decodeFull(encoded);
  assert(uri == decoded);
}

void parsingURIs() {
  var uri =
    Uri.parse('https://example.org:8080/foo/bar#frag');

  assert(uri.scheme == 'https');
  assert(uri.host == 'example.org');
  assert(uri.path == '/foo/bar');
  assert(uri.fragment == 'frag');
  assert(uri.origin == 'https://example.org:8080');
}

void buildingURIs() {
  var uri = Uri(
    scheme: 'https',
    host: 'example.org',
    path: '/foo/bar',
    fragment: 'frag'
  );

  assert(uri.toString() == 'https://example.org/foo/bar#frag');
}

// https://dart.dev/guides/libraries/library-tour#dates-and-times
void creatingDates() {
  // Get the current date and time.
  var now = DateTime.now();

  // Create a new DateTime with the local time zone.
  var y2k = DateTime(2000); // January 1, 2000

  // Specify the month and day.
  y2k = DateTime(2000, 1, 2); // January 2, 2000

  // Specify the date as a UTC time.
  y2k = DateTime.utc(2000); // 1/1/2000, UTC

  // Specify a date and time in ms since the Unix epoch.
  y2k = DateTime.fromMillisecondsSinceEpoch(946684800000,
      isUtc: true);

  // Parse an ISO 8601 date.
  y2k = DateTime.parse('2000-01-01T00:00:00Z');
}

void getMillisecondsSinceEpoch() {
  // 1/1/2000, UTC
  var y2k = DateTime.utc(2000);
  assert(y2k.millisecondsSinceEpoch == 946684800000);

  // 1/1/1970, UTC
  var unixEpoch = DateTime.utc(1970);
  assert(unixEpoch.millisecondsSinceEpoch == 0);
}

void durationExamples() {
  var y2k = DateTime.utc(2000);

  // Add one year.
  var y2001 = y2k.add(const Duration(days: 366));
  assert(y2001.year == 2001);

  // Subtract 30 days.
  var december2000 =
      y2001.subtract(const Duration(days: 30));
  assert(december2000.year == 2000);
  assert(december2000.month == 12);

  // Calculate the difference between two dates.
  // Returns a Duration object.
  var duration = y2001.difference(y2k);
  assert(duration.inDays == 366); // y2k was a leap year.
}

// https://dart.dev/guides/libraries/library-tour#utility-classes
class Line implements Comparable<Line> {
  final int length;
  const Line(this.length);

  @override
  int compareTo(Line other) => length - other.length;
}

void comparingObjects() {
  var short = const Line(1);
  var long = const Line(100);
  assert(short.compareTo(long) < 0);
}

class PersonHash {
  final String firstName, lastName;

  PersonHash(this.firstName, this.lastName);

  // Override hashCode using strategy from Effective Java,
  // Chapter 11.
  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + firstName.hashCode;
    result = 37 * result + lastName.hashCode;
    return result;
  }

  // You should generally implement operator == if you
  // override hashCode.
  @override
  bool operator ==(dynamic other) {
    return other is PersonHash &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }
}

void implementingMapKeys() {
  var p1 = PersonHash('Bob', 'Smith');
  var p2 = PersonHash('Bob', 'Smith');
  var p3 = 'not a person';
  assert(p1.hashCode == p2.hashCode);
  assert(p1 == p2);
  assert(p1 != p3);
}

class Process {
  // Represents a process...
}

class ProcessIterator implements Iterator<Process> {
  @override
  Process get current => new Process();
  @override
  bool moveNext() => true;
}

// A mythical class that lets you iterate through all
// processes. Extends a subclass of [Iterable].
class Processes extends Iterable<Process> {
  @override
  final Iterator<Process> iterator = ProcessIterator();
}

void iterationExamples() {
  // Iterable objects can be used with for-in.
  for (var process in Processes()) {
    // Do something with the process.
  }
}

// https://dart.dev/guides/libraries/library-tour#exceptions
class FooException implements Exception {
  final String? msg;

  const FooException([this.msg]);

  @override
  String toString() => msg ?? 'FooException';
}

void exceptionsExamples() {
  FooException fe = new FooException();
  print(fe.toString());
}

// https://dart.dev/guides/libraries/library-tour#future
Future findEntryPoint() => new Future(() => true);
Future runExecutable(int entryPoint) => new Future(() => true);
Future flushThenExit([int ?code]) => new Future(() => true);

void futureExample() {
  /*
  findEntryPoint().then((entryPoint) {
    return runExecutable(entryPoint);
  }).then(flushThenExit);
  */
}

Future<void> runUsingAsyncAwait() async {
  var entryPoint = await findEntryPoint();
  var exitCode = await runExecutable(entryPoint);
  await flushThenExit(exitCode);
}

Future<void> runUsingAsyncAwaitWithException() async {
  var entryPoint = await findEntryPoint();
  try {
    var exitCode = await runExecutable(entryPoint);
    await flushThenExit(exitCode);
  } catch (e) {
    // Handle the error...
  }
}

void futureHttpExample() {
  String url = '';

  dartHTML.HttpRequest.getString(url).then((String result) {
    print(result);
  });

  dartHTML.HttpRequest.getString(url).then((String result) {
    print(result);
  }).catchError((e) {
    // Handle or ignore the error.
  });
}

Future costlyQuery(url) => new Future(() => url);
Future expensiveWork(value) => new Future(() => value);
Future lengthyComputation() => new Future(() => true);

void chainingMultipleAsynchronousMethods(url) async {
  // Future
  Future result = costlyQuery(url);

  result
    .then((value) => expensiveWork(value))
    .then((_) => lengthyComputation())
    .then((_) => print('Done'))
    .catchError((exception) {
      print('Error');
    });

  // Await
  try {
    final value = await costlyQuery(url);
    await expensiveWork(value);
    await lengthyComputation();
    print('Done!');
  } catch (e) {
    /* Handle exception... */
  }
}

Future<void> deleteLotsOfFiles() async => new Future(() => true);
Future<void> copyLotsOfFiles() async => new Future(() => true);
Future<void> checksumLotsOfOtherFiles() async => new Future(() => true);

void waitingForMultipleFutures() async {
  await Future.wait([
    deleteLotsOfFiles(),
    copyLotsOfFiles(),
    checksumLotsOfOtherFiles(),
  ]);

  print('Done with all the long steps!');
}

// https://dart.dev/guides/libraries/library-tour#stream
void streamExample() {
  /*
  FileSystemEntity.isDirectory(searchPath).then((isDir) {
    if (isDir) {
      final startingDir = Directory(searchPath);
      startingDir.list().listen((entity) {
        if (entity is File) {
          searchFile(entity, searchTerms);
        }
      });
    } else {
      searchFile(File(searchPath), searchTerms);
    }
  });
  */

  /*
  // await example
  if (await FileSystemEntity.isDirectory(searchPath)) {
    final startingDir = Directory(searchPath);
    await for (var entity in startingDir.list()) {
      if (entity is File) {
        searchFile(entity, searchTerms);
      }
    }
  } else {
    searchFile(File(searchPath), searchTerms);
  }
  */
}

void listeningForStreamData() {
  /*
  // Add an event handler to a button.
  submitButton.onClick.listen((e) {
    // When the button is clicked, it runs this code.
    submitData();
  });
  */
}

void transformingStreamData(Stream<List<int>> inputStream) {

  var lines = inputStream
    .transform(utf8.decoder)
    .transform(LineSplitter());
}

Future<void> handlingErrorsAndCompletion() async {
  var config = dartIO.File('config.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = inputStream
      .transform(utf8.decoder)
      .transform(LineSplitter());

  try {
    await for (var line in lines) {
      print('Got ${line.length} characters from stream');
    }
    print('file is now closed');
  } catch (e) {
    print(e);
  }

  // stream
  inputStream
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .listen((String line) {
    print('Got ${line.length} characters from stream');
  }, onDone: () {
    print('file is now closed');
  }, onError: (e) {
    print(e);
  });
}

// https://dart.dev/guides/libraries/library-tour#trigonometry
void mathTrigonometryExample() {
  // Cosine
  assert(cos(pi) == -1.0);

  // Sine
  var degrees = 30;
  var radians = degrees * (pi / 180);
  // radians is now 0.52359.
  var sinOf30degrees = sin(radians);
  // sin 30° = 0.5
  assert((sinOf30degrees - 0.5).abs() < 0.01);
}

// https://dart.dev/guides/libraries/library-tour#maximum-and-minimum
void maximumAndMinimumExamples() {
  assert(max(1, 1000) == 1000);
  assert(min(1, -1000) == -1000);
}

// https://dart.dev/guides/libraries/library-tour#math-constants
void mathConstantsExamples() {
  // See the Math library for additional constants.
  print(e); // 2.718281828459045
  print(pi); // 3.141592653589793
  print(sqrt2); // 1.4142135623730951
}

// https://dart.dev/guides/libraries/library-tour#random-numbers
void randomNunbersExample() {
  var random = Random();
  random.nextDouble(); // Between 0.0 and 1.0: [0, 1)
  random.nextInt(10); // Between 0 and 9.
  random.nextBool(); // true or false
}

// https://dart.dev/guides/libraries/library-tour#decoding-and-encoding-json
void decodingJson() {
  // NOTE: Be sure to use double quotes ("),
  // not single quotes ('), inside the JSON string.
  // This string is JSON, not Dart.
  var jsonString = '''
    [
      {"score": 40},
      {"score": 80}
    ]
  ''';

  var scores = jsonDecode(jsonString);
  assert(scores is List);

  var firstScore = scores[0];
  assert(firstScore is Map);
  assert(firstScore['score'] == 40);
}

void encodingJson() {
  var scores = [
    {'score': 40},
    {'score': 80},
    {'score': 100, 'overtime': true, 'special_guest': null}
  ];

  var jsonText = jsonEncode(scores);
  assert(jsonText ==
      '[{"score":40},{"score":80},'
          '{"score":100,"overtime":true,'
          '"special_guest":null}]');
}

// https://dart.dev/guides/libraries/library-tour#decoding-and-encoding-utf-8-characters
List<int> utf8Bytes = [
  0xc3, 0x8e, 0xc3, 0xb1, 0xc5, 0xa3, 0xc3, 0xa9,
  0x72, 0xc3, 0xb1, 0xc3, 0xa5, 0xc5, 0xa3, 0xc3,
  0xae, 0xc3, 0xb6, 0xc3, 0xb1, 0xc3, 0xa5, 0xc4,
  0xbc, 0xc3, 0xae, 0xc5, 0xbe, 0xc3, 0xa5, 0xc5,
  0xa3, 0xc3, 0xae, 0xe1, 0xbb, 0x9d, 0xc3, 0xb1
];

void decodingUTF8() {
  var funnyWord = utf8.decode(utf8Bytes);

  assert(funnyWord == 'Îñţérñåţîöñåļîžåţîờñ');
}

void convertUTF8Stream(Stream<List<int>> inputStream ) async {
  var lines =
      utf8.decoder.bind(inputStream).transform(LineSplitter());
  try {
    await for (var line in lines) {
      print('Got ${line.length} characters from stream');
    }
    print('file is now closed');
  } catch (e) {
    print(e);
  }
}

void encodeUTF8() {
  List<int> encoded = utf8.encode('Îñţérñåţîöñåļîžåţîờñ');

  assert(encoded.length == utf8Bytes.length);
  for (int i = 0; i < encoded.length; i++) {
    assert(encoded[i] == utf8Bytes[i]);
  }
}

// https://dart.dev/guides/libraries/library-tour#manipulating-the-dom
void manipulatingTheDom() {
  // Find an element by id (an-id).
  dartHTML.Element idElement = dartHTML.querySelector('#an-id')!;

  // Find an element by class (a-class).
  dartHTML.Element classElement = dartHTML.querySelector('.a-class')!;

  // Find all elements by tag (<div>).
  List<dartHTML.Element> divElements = dartHTML.querySelectorAll('div');

  // Find all text inputs.
  List<dartHTML.Element> textInputElements = dartHTML.querySelectorAll(
    'input[type="text"]',
  );

  // Find all elements with the CSS class 'class'
  // inside of a <p> that is inside an element with
  // the ID 'id'.
  List<dartHTML.Element> specialParagraphElements = dartHTML.querySelectorAll('#id p.class');
}

void manipulatingElements() {
  /*
    <a id="example" href="/another/example">link text</a>
  */
  var anchor = dartHTML.querySelector('#example') as dartHTML.AnchorElement;
  anchor.href = 'https://dart.dev';

  /*
    <p>
      <span class="linux">Words for Linux</span>
      <span class="macos">Words for Mac</span>
      <span class="windows">Words for Windows</span>
    </p>
  */

  const osList = ['macos', 'windows', 'linux'];
  final userOs = dartIO.Platform.operatingSystem;

  // For each possible OS...
  for (final os in osList) {
    // Matches user OS?
    bool shouldShow = (os == userOs);

    // Find all elements with class=os. For example, if
    // os == 'windows', call querySelectorAll('.windows')
    // to find all elements with the class "windows".
    // Note that '.$os' uses string interpolation.
    for (final elem in dartHTML.querySelectorAll('.$os')) {
      elem.hidden = !shouldShow; // Show or hide.
    }
  }
}

void creatingElements() {
  var elem = dartHTML.ParagraphElement();
  elem.text = 'Creating is easy!';

  var elem2 = dartHTML.Element.html(
    '<p>Creating <em>is</em> easy!</p>',
  );

  dartHTML.document.body!.children.add(elem2);
}

void addReplaceRemove(elem) {
  dartHTML.querySelector('#inputs')!.nodes.add(elem);

  dartHTML.querySelector('#status')!.replaceWith(elem);

  dartHTML.querySelector('#expendable')?.remove();
}

void manipulatingCSS() {
  var elem = dartHTML.querySelector('#message')!;
  elem.classes.add('warning');

  var message = dartHTML.DivElement();
  message.id = 'message2';
  message.text = 'Please subscribe to the Dart mailing list.';

   message = dartHTML.DivElement()
    ..id = 'message2'
    ..text = 'Please subscribe to the Dart mailing list.';

  message.style
    ..fontWeight = 'bold'
    ..fontSize = '3em';
}

void handlingJSEvents() {
  // Find a button by ID and add an event handler.
  dartHTML.querySelector('#submitInfo')!.onClick.listen((e) {
    // When the button is clicked, it runs this code.
    // submitData();
  });

  dartHTML.document.body!.onClick.listen((e) {
    final clickedElem = e.target;
    // ...
  });
}

// https://dart.dev/guides/libraries/library-tour#using-http-resources-with-httprequest
void usingHTTPRequest(url) async {
    String pageHtml = await dartHTML.HttpRequest.getString(url);
  // Do something with pageHtml...
}

void handlingHTTPRequestError(jsonUri) async {
  try {
    var data = await dartHTML.HttpRequest.getString(jsonUri);
    // Process data...
  } catch (e) {
    // Handle exception...
  }
}

void gettingHTTPRequestMetadata(url) async {
  dartHTML.HttpRequest req = await dartHTML.HttpRequest.request(
    url,
    method: 'HEAD',
  );

  if (req.status == 200) {
    // Successful URL access...
  }
  // ···
}

void requestComplete(request) => {};

void httpRequestFlow(url, encodedData) {
  var request = dartHTML.HttpRequest();

  request
    ..open('POST', url)
    ..onLoadEnd.listen((e) => requestComplete(request))
    ..send(encodedData);
}

String encodeMap(Map<String, String> data) => data.entries
    .map((e) =>
        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
    .join('&');

void sendDataToTheServer(url) async {
  const data = {'dart': 'fun', 'angular': 'productive'};

  var request = dartHTML.HttpRequest();
  request
    ..open('POST', url)
    ..setRequestHeader(
      'Content-type',
      'application/x-www-form-urlencoded',
    )
    ..send(encodeMap(data));

  await request.onLoadEnd.first;

  if (request.status == 200) {
    // Successful URL access...
  }
  // ···
}

// https://dart.dev/guides/libraries/library-tour#sending-and-receiving-real-time-data-with-websockets
void sendigReceivingRealTimeData() {
  var ws = dartHTML.WebSocket('ws://echo.websocket.org');

  ws.send('Hello from Dart!');

  ws.onMessage.listen((dartHTML.MessageEvent e) {
    print('Received message: ${e.data}');
  });
}

void initWebSocket(time) => {};

void handlingWebsocketEvents([int retrySeconds = 1]) {
  var ws = dartHTML.WebSocket('ws://echo.websocket.org');
  var reconnectScheduled = false;

  print('Connecting to websocket');

  void scheduleReconnect() {
    if (!reconnectScheduled) {
      dartAsync.Timer(Duration(seconds: retrySeconds),
          () => initWebSocket(retrySeconds * 2));
    }
    reconnectScheduled = true;
  }

  ws.onOpen.listen((e) {
    print('Connected');
    ws.send('Hello from Dart!');
  });

  ws.onClose.listen((e) {
    print('Websocket closed, retrying in $retrySeconds seconds');
    scheduleReconnect();
  });

  ws.onError.listen((e) {
    print('Error connecting to ws');
    scheduleReconnect();
  });

  ws.onMessage.listen((dartHTML.MessageEvent e) {
    print('Received message: ${e.data}');
  });
}

// https://dart.dev/guides/libraries/library-tour#dartio
// https://dart.dev/guides/libraries/library-tour#files-and-directories
Future<void> filesAndDirectories() async {
  var config = dartIO.File('config.txt');

  // Put the whole file in a single string.
  var stringContents = await config.readAsString();
  print('The file is ${stringContents.length} characters long.');

  // Put each line of the file into its own string.
  var lines = await config.readAsLines();
  print('The file is ${lines.length} lines long.');
}

Future<void> readingFileAsBinary() async {
  var config = dartIO.File('config.txt');

  var contents = await config.readAsBytes();
  print('The file is ${contents.length} bytes long.');
}

Future<void> handlingReadingFilesError() async {
  var config = dartIO.File('config.txt');

  try {
    var contents = await config.readAsString();
    print(contents);
  } catch (e) {
    print(e);
  }
}

Future<void> streamingFileContents() async {
  var config = dartIO.File('config.txt');

  Stream<List<int>> inputStream = config.openRead();

  var lines = utf8.decoder
      .bind(inputStream)
      .transform(const LineSplitter());

  try {
    await for (final line in lines) {
      print('Got ${line.length} characters from stream');
    }
    print('file is now closed');
  } catch (e) {
    print(e);
  }
}

void writingFileContents() async {
  var logFile = dartIO.File('log.txt');
  var sink = logFile.openWrite();
  sink.write('FILE ACCESSED ${DateTime.now()}\n');
  await sink.flush();
  await sink.close();

  // add to end of file
  sink = logFile.openWrite(mode: dartIO.FileMode.append);
}

Future<void> listingFilesInDirectory() async {
  var dir = dartIO.Directory('tmp');

  try {
    var dirList = dir.list();
    await for (final dartIO.FileSystemEntity f in dirList) {
      if (f is dartIO.File) {
        print('Found file ${f.path}');
      } else if (f is dartIO.Directory) {
        print('Found dir ${f.path}');
      }
    }
  } catch (e) {
    print(e.toString());
  }
}

// https://dart.dev/guides/libraries/library-tour#http-clients-and-servers
Future<void> httpServer() async {
  final requests = await dartIO.HttpServer.bind('localhost', 8888);
  await for (final request in requests) {
    processRequest(request);
  }
}

void processRequest(dartIO.HttpRequest request) {
  print('Got request for ${request.uri.path}');
  final response = request.response;
  if (request.uri.path == '/dart') {
    response
      ..headers.contentType = dartIO.ContentType(
        'text',
        'plain',
      )
      ..write('Hello from the server');
  } else {
    response.statusCode = dartIO.HttpStatus.notFound;
  }
  response.close();
}

Future<void> httpClient() async {
  var url = Uri.parse('http://localhost:8888/dart');
  var httpClient = dartIO.HttpClient();

  var request = await httpClient.getUrl(url);
  var response = await request.close();

  var data = await utf8.decoder.bind(response).toList();
  print('Response ${response.statusCode}: $data');
  
  httpClient.close();
}
