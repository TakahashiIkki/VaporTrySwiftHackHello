import Vapor

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.resource("posts", PostController())

// hello アクションに対しての対応を追加
drop.get("hello") { req in
    return try drop.view.make("enjoy.html")
}

// json アクションに対しての対応を追加
drop.get("json") { req in
    return try JSON(node: [
        "number": 1,
        "text"  : "TrySwiftHack",
        "bool"  : true,
    ])
}

drop.group("v1") { v1 in
    v1.get("json") { request in
        return try JSON(node: [
            "number": 3,
            "text"  : "TrySwiftHack v1",
            "bool"  : true,
        ])
    }
}

drop.group("v2") { v1 in
    v1.get("json") { request in
        return try JSON(node: [
            "number": 1,
            "text"  : "TrySwiftHack v1",
            "body"  : "Vapor Separating By Version",
            "bool"  : true,
        ])
    }
}

drop.run()
