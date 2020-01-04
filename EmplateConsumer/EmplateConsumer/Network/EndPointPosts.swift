//
//  EndPointPosts.swift
//  EmplateConsumer
//
//  Created by Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import Foundation
import Moya

public enum EndPointPosts {
    static private let apiKey = Constants.apiKey

  case posts
}

extension EndPointPosts: TargetType {

  public var baseURL: URL {
    return URL(string: Constants.baseURL)!
  }

  public var path: String {
    switch self {
    case .posts: return Constants.postsPath
    }
  }

  public var method: Moya.Method {
    switch self {
    case .posts: return .get
    }
  }

  public var sampleData: Data {
    return Data()
  }

  public var task: Task {
    //return .requestPlain // TODO
    return .requestParameters(parameters: ["include": "postfields,postperiods,thumbnail"],
                                  encoding: URLEncoding.default)
  }

    public var headers: [String: String]? {
        
        var header = [String : String]()
        header["Content-Type"] = "application/json"
        header["Accept"] = "application/json"
        header["X-Api-Key"] = EndPointPosts.apiKey
        
        return header
        
    }

  public var validationType: ValidationType {
    return .successCodes
  }
}
