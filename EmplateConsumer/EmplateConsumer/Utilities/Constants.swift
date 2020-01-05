//
//  Constants.swift
//  EmplateConsumer
//
//  Created by Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class Constants: NSObject {
    
    static let baseURL = "https://emplate.dev/v9/"
    static let apiKey = "$2y$10$gpin5yXpMxbjWvsnnDMhLOYO7kpZSag7CKIDndWmUeJ/4WEchaAxK"
    static let postsPath = "posts"
    
    
    static let postsTableAccessIdntefier = "identTableView"
    static let postsTableEstimatedRowHeight = CGFloat(471)
    static let postsCellImageDefaultHeight = 250
    
    //add loader custmization
    static let colorGreen = #colorLiteral(red: 0, green: 0.568627451, blue: 0.5568627451, alpha: 1)
    static let activityLoaderData = ActivityData(type: .ballScaleMultiple, color: Constants.colorGreen, minimumDisplayTime:0,backgroundColor:UIColor.clear)
    
    
}
