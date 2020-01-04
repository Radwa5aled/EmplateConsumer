//
//  PostModel.swift
//  EmplateConsumer
//
//  Created by Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import Foundation


// MARK: - PostsModel
struct PostsModel: Codable {
    
    var type: String?
    var id: Int?
    var name: String?
    var approved, collectible: Bool?
    var parameters: String?
    var url: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?
    var postfields: [Postfield]?
    var postperiods: [Postperiod]?
    var thumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case type, id, name, approved, collectible, parameters, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case postfields, postperiods, thumbnail
    }
}

// MARK: - Postfield
struct Postfield: Codable {
    var type: String?
    var id, postID, postFieldTypeID, order: Int?
    var content: String?
    var createdAt, updatedAt: String?
    
    var contentObject: ContentModel {
        return ContentModel.map(JSONString:content ?? "")!
    }
    
    enum CodingKeys: String, CodingKey {
        case type, id
        case postID = "post_id"
        case postFieldTypeID = "postFieldType_id"
        case order, content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

// MARK: - Postperiod
struct Postperiod: Codable {
    var type: String?
    var id: Int?
    var start, stop, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case type, id, start, stop
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    var type: String?
    var id: Int?
    var name: String?
    var filetype: String?
    var width, height: Int?
    var urls: ThumbnailUrls?
}

// MARK: - Urls
struct ThumbnailUrls: Codable {
    var original, large, mobile, thumbnail: String?
}

// MARK: - ContentModel
struct ContentModel: Decodable{
       var redeemable: Bool?
       var text: String?
       var images: [Int]?
       var price: String?
       var priceBefore: String?
       var discount: String?
}

