var MongoClient = require('mongodb').MongoClient;
var url = process.env.MONGODB_URI;

MongoClient.connect(url, function(err, db) {
    if (err) throw err;
    var dbo = db.db("mydb");
    for (let i = 0; i < 100; i++) {
        var user = {email: "ab_" + i  +"@ab.com", username: "ab"+i, password: "ab"};
        var item = {
            title: "item_ab" + i,
            "description": "Ever wonder how?",
            body: "Very carefully.",
            "tagList": '["dragons","training"]}}'
        }
        var comment = {seller: user, item: item, body: "comment of item and seller " + i}
        dbo.collection("users").insertOne(user, function (err, res) {
            if (err) throw err;
            console.log("1 user inserted");
        });

        dbo.collection("items").insertOne(item, function (err, res) {
            if (err) throw err;
            console.log("1 item inserted");
        });

        dbo.collection("comments").insertOne(comment, function (err, res) {
            if (err) throw err;
            console.log("1 comment inserted");
            db.close();
        });
    }
});