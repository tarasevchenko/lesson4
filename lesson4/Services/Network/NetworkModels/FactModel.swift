//
//  CatsModels.swift
//  lesson4
//
//  Created by Тарас Евченко on 08.11.2021.
//

import Foundation
import RealmSwift

class Fact: Object, Codable {
  
  @Persisted var v: Int?
  @Persisted var id: String?
  @Persisted var createdAt: String?
  @Persisted var deleted: Bool?
  @Persisted var source: String?
  @Persisted var status: Status?
  @Persisted var text: String?
  @Persisted var type: String?
  @Persisted var updatedAt: String?
  @Persisted var used: Bool?
  @Persisted var user: String?
  
  enum CodingKeys: String, CodingKey {
    case v = "__v"
    case id = "_id"
    case createdAt = "createdAt"
    case deleted = "deleted"
    case source = "source"
    case status
    case text = "text"
    case type = "type"
    case updatedAt = "updatedAt"
    case used = "used"
    case user = "user"
  }
  
  convenience required init(from decoder: Decoder) throws {
    self.init()
    let values = try decoder.container(keyedBy: CodingKeys.self)
    v = try values.decodeIfPresent(Int.self, forKey: .v) ?? nil
    id = try values.decodeIfPresent(String.self, forKey: .id) ?? nil
    createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? nil
    deleted = try values.decodeIfPresent(Bool.self, forKey: .deleted) ?? nil
    source = try values.decodeIfPresent(String.self, forKey: .source) ?? nil
    status = try Status(from: decoder)
    text = try values.decodeIfPresent(String.self, forKey: .text) ?? nil
    type = try values.decodeIfPresent(String.self, forKey: .type) ?? nil
    updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt) ?? nil
    used = try values.decodeIfPresent(Bool.self, forKey: .used) ?? nil
    user = try values.decodeIfPresent(String.self, forKey: .user) ?? nil
  }
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
}

class Status : Object,Codable {
  
  @Persisted var sentCount : Int?
  @Persisted var verified : Bool?
  
  enum CodingKeys: String, CodingKey {
    case sentCount = "sentCount"
    case verified = "verified"
  }
  
  convenience required init(from decoder: Decoder) throws {
    self.init()
    let values = try decoder.container(keyedBy: CodingKeys.self)
    sentCount = try values.decodeIfPresent(Int.self, forKey: .sentCount) ?? nil
    verified = try values.decodeIfPresent(Bool.self, forKey: .verified) ?? nil
  }
  
}
