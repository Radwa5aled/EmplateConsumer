//
//  Utilities.swift
//  EmplateConsumer
//
//  Created by Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

public class  Utilities {
    
    private init() {}
    static let shared = Utilities()
    
    
    //----------------------------------------------------------------------
    //MARK:- Get image width and height factor then apply it on image view height according to mobile width
    func getWidth_HeightFactor(viewWidth: CGFloat, width: CGFloat, height: CGFloat) -> CGFloat {
        if height != 0 && width != 0 {
            let scaleFactor = viewWidth / width
            let newHeight = height * scaleFactor
            return newHeight
        }
        
       return 250
    }
    
    //----------------------------------------------------------------------
    //MARK:- Get Expiration date if passed | hours,min,sec if today | start date if not come yet
    func getExpirationDateFromCurent(stopDateStr:String, startDateStr: String) -> String {
        
        var newDate = ""
        
        let dateFormatter = DateFormatter()
        //2019-12-31T22:59:00+00:00
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //"yyyy-MM-dd'T'HH:mm:ss'Z'"//"yyyy-MM-dd'T'HH:mm:ssZ"
        
        let startDate = dateFormatter.date(from: startDateStr)
        
        if let stopDate = dateFormatter.date(from: stopDateStr) {
            
            if Calendar.current.isDate(stopDate, inSameDayAs:Date()) { //Date is today
                
                let diffInHours = Calendar.current.dateComponents([.hour], from: stopDate, to: Date()).hour
                let diffInMins = Calendar.current.dateComponents([.minute], from: stopDate, to: Date()).minute
                let diffInSecds = Calendar.current.dateComponents([.second], from: stopDate, to: Date()).second
               
                if let h = diffInHours, h > 0 {
                   newDate = "Expires in \(h) hours"
                }else {
                    if let min = diffInMins, min > 0 {
                        newDate = "Expires in \(min) minutes"
                    }else {
                        if let sec = diffInSecds, sec > 0 {
                             newDate = "Expires in \(sec) seconds"
                        }
                    }
                }
                
                
            }else { //Date not today
                
                dateFormatter.dateFormat = "dd-MM-yyyy"
                if stopDate < Date() { // Date passed
                    
                    newDate = "Expired on " + dateFormatter.string(from: stopDate)
                    
                }else { // Date not come yet, so display offer start date
                    
                    if let sD = startDate {
                       newDate = "Starts in " + dateFormatter.string(from: sD)
                    }
                }
               
            }
        }

         return newDate
        
    }
    
    //----------------------------------------------------------------------
    //MARK:- make some part of string to strike
    func getAttributedStr(str:String) -> NSMutableAttributedString {
        
        let allString = "Før: " + str
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: allString)

        let somePartStringRange = (allString as NSString).range(of: str)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: somePartStringRange)
        
        return attributeString
    }
    
    //----------------------------------------------------------------------
    //MARK:- download image from url without caching it using kingfisher
    func downloadImageFromUrl(tmbUrlStr:String, success:@escaping(_ img: UIImage)->(Void) , failure:@escaping (_ error :String)->(Void)) {
        
        if let thumbUrl = URL(string: tmbUrlStr ) {
            
            let downloader = ImageDownloader.default
            downloader.downloadImage(with: thumbUrl) { result in
                switch result {
                case .success(let value):
                    success(value.image)
                    
                case .failure(let error):
                    failure(error.localizedDescription)
                }
            }
            
        }
        
    }

    
}
