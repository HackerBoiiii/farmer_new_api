// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.status,
    this.message,
    this.totalRec,
    this.data,
  });

  bool status;
  String message;
  int totalRec;
  List<Datum> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    status: json["status"],
    message: json["message"],
    totalRec: json["total_rec"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "total_rec": totalRec,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.cid,
    this.category,
    this.cdesc,
    this.cImg,
    this.cdata,
  });

  String cid;
  String category;
  String cdesc;
  String cImg;
  List<Cdatum> cdata;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    cid: json["cid"],
    category: json["category"],
    cdesc: json["cdesc"],
    cImg: json["c_img"],
    cdata: List<Cdatum>.from(json["cdata"].map((x) => Cdatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "category": category,
    "cdesc": cdesc,
    "c_img": cImg,
    "cdata": List<dynamic>.from(cdata.map((x) => x.toJson())),
  };
}

class Cdatum {
  Cdatum({
    this.pid,
    this.cid,
    this.type,
    this.image,
    this.name,
    this.description,
    this.costPrice,
    this.sellPrice,
    this.unit,
    this.totalQty,
    this.approve,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.farmerName,
  });

  String pid;
  String cid;
  String type;
  String image;
  String name;
  String description;
  String costPrice;
  String sellPrice;
  Unit unit;
  String totalQty;
  String approve;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  FarmerName farmerName;

  factory Cdatum.fromJson(Map<String, dynamic> json) => Cdatum(
    pid: json["pid"],
    cid: json["cid"],
    type: json["type"],
    image: json["image"],
    name: json["name"],
    description: json["description"],
    costPrice: json["cost_price"],
    sellPrice: json["sell_price"],
    unit: unitValues.map[json["unit"]],
    totalQty: json["total_qty"],
    approve: json["approve"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdBy: json["created_by"],
    farmerName: farmerNameValues.map[json["farmerName"]],
  );

  Map<String, dynamic> toJson() => {
    "pid": pid,
    "cid": cid,
    "type": type,
    "image": image,
    "name": name,
    "description": description,
    "cost_price": costPrice,
    "sell_price": sellPrice,
    "unit": unitValues.reverse[unit],
    "total_qty": totalQty,
    "approve": approve,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "created_by": createdBy,
    "farmerName": farmerNameValues.reverse[farmerName],
  };
}

enum FarmerName { ZET, FARMERNAME, FRESH_ON_THE_GO_FARMER }

final farmerNameValues = EnumValues({
  "farmername": FarmerName.FARMERNAME,
  "Fresh on the go farmer": FarmerName.FRESH_ON_THE_GO_FARMER,
  "Zet": FarmerName.ZET
});

enum Unit { PCS, CASES, LBS }

final unitValues = EnumValues({
  "Cases": Unit.CASES,
  "Lbs": Unit.LBS,
  "Pcs": Unit.PCS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
