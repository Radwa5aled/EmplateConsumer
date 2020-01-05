//
//  PostsInteractor.swift
//  EmplateConsumer
//
//  Created Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//


import UIKit
import Moya

class PostsInteractor: PostsInteractorInputProtocol {
    
    weak var presenter: PostsInteractorOutputProtocol?
    
    let endPointPostsProvider = MoyaProvider<EndPointPosts>()
    
    func callPostsApiInteractor() {
        endPointPostsProvider.request(.posts) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    
                    let jsonDecoder = JSONDecoder()
                    let postsModel = try jsonDecoder.decode([PostsModel].self, from: response.data)
                    self.presenter?.successGetPostsInPresenter(model:postsModel)
                    
                } catch let error {
                    self.presenter?.failGetPostsInPresenter(error: error.localizedDescription)
                }
            case .failure:
                self.presenter?.failGetPostsInPresenter(error: (result.error?.errorDescription) ?? "")
                
            }
        }
    }
}

