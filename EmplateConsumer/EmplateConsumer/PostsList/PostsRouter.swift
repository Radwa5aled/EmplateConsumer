//
//  PostsRouter.swift
//  EmplateConsumer
//
//  Created Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//

import UIKit

class PostsRouter: PostsWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {

        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        let interactor = PostsInteractor()
        let router = PostsRouter()
        let presenter = PostsPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
