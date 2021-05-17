//
//  HomeView.swift
//  Blockers
//
//  Created by Rohit on 14/05/21.
//

import UIKit

class HomeView: UIViewController , UITabBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
   
    
 
    

   
    var postsData : [MyPost]? = []
    var url : String = ""
    let cellSpacingheight : CGFloat = 4
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["General","Development","Finance"])
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = UIColor(named:"tc")
        sc.addTarget(self, action: #selector(handleSegmentedChange), for: .valueChanged)
        
        return sc
    }()
    
    @objc fileprivate func handleSegmentedChange() {
           print(segmentedControl.selectedSegmentIndex)
           
           switch segmentedControl.selectedSegmentIndex {
           case 0 : url = "https://firebase-function-api.herokuapp.com/post/?type=general"
               fetchPostData(url: url, compi: {
                   (data) in
                   self.postsData = data
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                       
                   }
                  
               })
               
           case 1:
               url = "https://firebase-function-api.herokuapp.com/post/?type=developments"
                fetchPostData(url: url, compi: {
                    (data) in
                    self.postsData = data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                   
                })
          
        case 2:url = "https://firebase-function-api.herokuapp.com/post/?type=finance"
            fetchPostData(url: url, compi: {
                (data) in
                self.postsData = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
               
            })
        default:
            url = "https://firebase-function-api.herokuapp.com/post/?type=general"
                fetchPostData(url: url, compi: {
                    (data) in
                    self.postsData = data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                   
                })
        }
        
    }
    
    
    let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
       url =   "https://firebase-function-api.herokuapp.com/post/?type=general"
//
        fetchPostData(url: url, compi: {
            (data) in
            self.postsData = data
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }

        })

      
        
        let stackView = UIStackView(arrangedSubviews: [segmentedControl,tableView])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor ,leading: view.leadingAnchor , bottom: view.bottomAnchor ,trailing:view.trailingAnchor,padding: .zero )
      
        

        
        
        
      
        
    }

    func fetchPostData(url:String,compi: @escaping([MyPost])->()){
        let url1 = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url1){
            (data,response,error) in
            guard let data = data else {return }
            do {
                let postsData = try JSONDecoder().decode([MyPost].self, from: data)
                print(postsData.count)
               
                compi(postsData)
                
                
            }catch {
                let error = error
                print(error)
                
            }
        }.resume()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(postsData?.count)
        return postsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell : MyCell? = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MyCell
//
////        cell.textLabel?.text = postsData?[indexPath.row].post
//        if cell == nil {
//            cell = Bundle.main.loadNibNamed("MyCell", owner: self, options: nil)?.first as? MyCell
//        }
////        cell?.PostLabel.text = postsData?[indexPath.row].post
////          cell?.ProfileLogo.image = UIImage(named: "\(indexPath.row + 3)")
//        cell?.title.text = "UserId=dxcfvghbjkljhgbzbdxcfhgvjhbjnlkj xzgdgxchgvjhbkjnkjmhngbfvzjfhgzkgjhgvc\(postsData?[indexPath.row].user_id)"
////        cell?.backgroundColor = UIColor.white
      

        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
               cell.textLabel?.text = postsData?[indexPath.row].post
               cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        cell.textLabel?.numberOfLines = 0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        cell.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 5)
      
        cell.layer.shadowColor = UIColor.blue.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowRadius = 4.0
        cell.layer.masksToBounds  = false
       
        
        let image = UIImage(named: "\(indexPath.row + 1 )")
       let targetSize = CGSize(width: 50, height: 50)
        cell.imageView?.image = image?.scalePreservingAspectRatio(targetSize: targetSize)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 20
        
        cell.detailTextLabel?.text = "PostedBy UserId:\(postsData?[indexPath.row].user_id ?? "")"
               cell.detailTextLabel?.numberOfLines = 0

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "AnswerViewController") as? AnswerViewController
        vc?.postData = postsData?[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }


    
    
    

}


 


