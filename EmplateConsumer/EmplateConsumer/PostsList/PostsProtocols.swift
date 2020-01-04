//
//  PostsProtocols.swift
//  EmplateConsumer
//
//  Created Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//


import Foundation

protocol SuperViewProtocol: class {
    func startLoading()
    func finishLoading()
}

//MARK: Wireframe -
protocol PostsWireframeProtocol: class {
    /* Presenter -> Router */
}
//MARK: Presenter -
protocol PostsPresenterProtocol: class {

    var interactor: PostsInteractorInputProtocol? { get set }
      func callPostsApiPresenter()
}

//MARK: Interactor -
protocol PostsInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func successGetPostsInPresenter(model: [PostsModel])
     func failGetPostsInPresenter(error: String)
}

protocol PostsInteractorInputProtocol: class {

    var presenter: PostsInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
     func callPostsApiInteractor()
}

//MARK: View -
protocol PostsViewProtocol: SuperViewProtocol {

    var presenter: PostsPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
       func onSuccessInController(model: [PostsModel])
       func onFailInController(error: String)
}
