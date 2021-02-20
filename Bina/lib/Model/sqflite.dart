import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserBasket {
  Database database;

  // Ini databsae
  void createBasket() async {
    var db = await openDatabase("Bina.db");
    // print("LOG : $db");
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'db.db');
    // print("LOG : $path");
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE myBasket (id INTEGER PRIMARY KEY, img TEXT, name_ar TEXT, name_kur TEXT, price DECIMAL(10,2), count INT)");
    });
  }

  Future getDatabase() async {
    var db = await openDatabase("Bina.db");
    // print("LOG : $db");
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'db.db');
    // print("LOG : $path");
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE myBasket (id INTEGER PRIMARY KEY, img TEXT, name_ar TEXT, name_kur TEXT, price DECIMAL(10,2), count INT)");
    });
    return database;
  }

  // Read From DataBase
  Future<List<Map>> readMyBasket() async {
    // For opening db
    Database db = await getDatabase();

    List<Map> myBasketList = await db.rawQuery("SELECT * FROM myBasket");
    return myBasketList;
  }

  // Adding a user basket
  Future<bool> addMyBasket({id, img, name_ar, name_kur, price, count}) async {
    Database db = await getDatabase();

    try {
      await db.transaction((txn) async {
        int idAdder = await txn.rawInsert(
            "insert into myBasket values($id, '$img', '$name_ar', '$name_kur' , $price, $count);");
        // print("This is $idAdder");
      });
      return true;
    } catch (e) {
      print("ERROR LOG FROM SQFLIT INSERTION $e");
      return false;
    }
  }

  // proc for getting sum of all price
  Future<dynamic> getSumOfProductPrice() async {
    Database db = await getDatabase();
    var sum;
    try {
      await db.transaction((txn) async {
        sum = await txn
            .rawQuery("SELECT SUM(price * count) as 'sum' FROM myBasket");
      });
      return sum;
    } catch (e) {
      print("ERROR LOG GETTING ALL PRICE $e");
      return 0;
    }
  }

  // Update Product with count and  by id
  Future<bool> updateMyBasket({id, count}) async {
    Database db = await getDatabase();
    try {
      await db.transaction((txn) async {
        await txn.rawQuery("UPDATE myBasket SET count = $count WHERE id = $id");
      });
      return true;
    } catch (e) {
      print("ERROR LOG GETTING ALL PRICE $e");
      return false;
    }
  }

  // Delete user product basket by product id
  Future<bool> delProductBasket({id}) async {
    Database db = await getDatabase();
    try {
      await db.rawDelete("DELETE FROM myBasket WHERE id = $id");
      return true;
    } catch (e) {
      print("ERROR LOG SQFLIT Delete Product $e");
      return false;
    }
  }
}

class MySaved {
  Database database;
  void createSaved() async {
    var db = await openDatabase("Bina.db");
    print("LOG : $db");
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'db.db');
    print("LOG : $path");
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE mySaved (id INTEGER PRIMARY KEY, img TEXT, name TEXT)");
    });
  }

  Future<List<Map>> readMyBasket() async {
    // For opening db
    createSaved();
    List<Map> mySavedList = await database.rawQuery("SELECT * FROM mySaved");
    return mySavedList;
  }
}
