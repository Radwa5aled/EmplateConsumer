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
        
        tableView.register(UINib(nibName: "\(PostCell.self)", bundle: nil), forCellReuseIdentifier: "\(PostCell.self)")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.postsTableEstimatedRowHeight
        
        //Identifier for table ui testing
        tableView.isAccessibilityElement = true
        tableView.accessibilityIdentifier = Constants.postsTableAccessIdntefier
        
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
        
        //Identifier for cell ui testing
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = String(format: "tVC_%d_%d",
                                              indexPath.section, indexPath.row)
        
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
