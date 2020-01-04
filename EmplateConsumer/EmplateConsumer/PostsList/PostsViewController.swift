//
//  PostsViewController.swift
//  EmplateConsumer
//
//  Created Radwa Khaled on 1/4/20.
//  Copyright © 2020 Radwa Khaled. All rights reserved.
//


import UIKit

class PostsViewController: UIViewController{
    
    // #MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // #MARK:- Used Params
    var presenter: PostsPresenterProtocol?
    var postsArr:[PostsModel] = []
    
    
    // #MARK:- View life cycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableData()
        
        presenter?.callPostsApiPresenter()
        
    }
    
    // #MARK:- Helper func
    func registerTableData() {
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(UINib(nibName: "PostCell",bundle: nil), forCellReuseIdentifier: "PostCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 471
    }
    
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.setData(model: postsArr[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension PostsViewController: PostsViewProtocol {
    
    func startLoading() {
        loading()
    }
    
    func finishLoading() {
        stopLoading()
    }
    
    func onSuccessInController(model: [PostsModel]) {
        
        if model.count == 0 {
            
            showFailView(to: self.view, targetView:self.view , isEnternet: false, msg: "Sorry, There is no results here"){}
            
        }else {
            hideFailView()
            self.postsArr = model
            self.tableView.reloadData()
        }
        
    }
    
    func onFailInController(error: String) {
        showFailView(to: self.view, targetView:self.view , isEnternet: true, msg: error) {
            self.presenter?.callPostsApiPresenter()
        }
    }
    
}
