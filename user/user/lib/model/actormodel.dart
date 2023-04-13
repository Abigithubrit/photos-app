import 'package:cloud_firestore/cloud_firestore.dart';

class ActorModel
{
  String? menuID;
  String? title;
  String? thumbnailUrl;
  String? status;

  ActorModel({
    this.menuID,
    this.title,
    this.thumbnailUrl,
    this.status,
  });

  ActorModel.fromJson(Map<String, dynamic> json)
  {
    menuID = json["menuID"];
    title = json['name'];
    thumbnailUrl = json['thumbnailUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["menuID"] = menuID;
    data["name"] = title;
    data['thumbnailUrl'] = thumbnailUrl;
    data['status'] = status;

    return data;
  }
}