//
//  PostsPresenter.swift
//  EmplateConsumer
//
//  Created Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//


class PostsPresenter: PostsPresenterProtocol, PostsInteractorOutputProtocol {
    
    weak private var view: PostsViewProtocol?
    var interactor: PostsInteractorInputProtocol?
    private let router: PostsWireframeProtocol
    
    init(interface: PostsViewProtocol, interactor: PostsInteractorInputProtocol?, router: PostsWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func callPostsApiPresenter() {
        view?.startLoading()
        interactor?.callPostsApiInteractor()
    }
    
    func successGetPostsInPresenter(model: [PostsModel]) {
        view?.finishLoading()
        view?.onSuccessInController(model: model)
    }
    
    func failGetPostsInPresenter(error: String) {
        view?.finishLoading()
        view?.onFailInController(error: error)
    }
    
}
