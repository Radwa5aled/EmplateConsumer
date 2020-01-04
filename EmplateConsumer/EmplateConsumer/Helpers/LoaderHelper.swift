//
//  LoaderHelper.swift
//  EmplateConsumer
//
//  Created by Radwa Khaled on 1/2/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

protocol Refreshable where Self: UIViewController {}

extension Refreshable {
    func loading(){
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(Constants.activityLoaderData)
    }
    
    func stopLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}

extension UIViewController:Refreshable{}
