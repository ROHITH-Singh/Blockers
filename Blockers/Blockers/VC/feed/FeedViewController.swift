//
//  FeedViewController.swift
//  Blockers
//
//  Created by Rohit on 19/06/21.
//

import UIKit
import SafariServices

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        return table
    }()
    private var articles = [Article]()
    private var ViewModels = [FeedTableViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .systemBackground
        FeedApiCaller.shared.getTopFeeds{ [weak self]
            result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.ViewModels = articles.compactMap({
                    FeedTableViewModel(title: $0.title ?? "" ,
                                       subtitle: $0.description ?? "No description",
                                       imageURL: URL(string: $0.urlToImage ?? "")
                                        )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                break
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(
            withIdentifier: "FeedCell",
                for: indexPath) as? FeedTableViewCell
            
         
            
        
        cell?.configure(with: ViewModels[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let  article = articles[indexPath.row]
        
        guard let  url = URL(string: article.url ?? "") else {
             return
        }
        let vc =  SFSafariViewController(url: url)
        present(vc,animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
    
}
