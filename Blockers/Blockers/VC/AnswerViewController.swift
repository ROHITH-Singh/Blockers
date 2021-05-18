//
//  AnswerViewController.swift
//  Blockers
//
//  Created by Rohit on 17/05/21.
//

import UIKit

class AnswerViewController: UIViewController , UITabBarDelegate, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myanswer?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
               cell.textLabel?.text = "\n \(myanswer?[indexPath.row].comment ?? "")\n"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        cell.textLabel?.numberOfLines = 0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2
        cell.detailTextLabel?.text = "PostedBy UserId:\(myanswer?[indexPath.row].user_id ?? "" )\n\n"
               cell.detailTextLabel?.numberOfLines = 0
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 8
        cell.backgroundColor = .white
        cell.selectionStyle = .none

        return cell
    }
    
    
    var postData: MyPost!
    var myanswer: [MyAnswer]? = []

    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var AnswerButton: UIButton!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var ProfileLogo: UIImageView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var AnswerList: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileLogo.image = UIImage(named: "\(Int.random(in: 0...12))")
        userId.text = "Posted BY \( postData.user_id ?? "")\n\n"
        QuestionLabel.text = "\(postData.post ?? "")\n"
        ProfileLogo.contentMode = .scaleAspectFill
        ProfileLogo.clipsToBounds = true
        ProfileLogo.layer.cornerRadius = 20
        AnswerButton.layer.cornerRadius = 5
        ShareButton.layer.cornerRadius = 5
        ShareButton.clipsToBounds = true
        AnswerButton.clipsToBounds = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        
        let url = "https://firebase-function-api.herokuapp.com/comment/?type=answer&p_commentid=\(postData.post_id ?? "")"
        
        fetchPostData(url: url, compi: {
            (data) in
            self.myanswer = data
            DispatchQueue.main.async {
                if self.myanswer?.count != 0 {
                    self.AnswerList.text =  "Number of answers = \(self.myanswer?.count)"
                }else{
                    self.AnswerList.text = "Be the first one to answer"
                }
                
               self.tableView.reloadData()

            }

        })
        
        // Do any additional setup after loading the view.
    }
    func fetchPostData(url:String,compi: @escaping([MyAnswer])->()){
        let url1 = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url1){
            (data,response,error) in
            guard let data = data else {return }
            do {
                let myanswer = try JSONDecoder().decode([MyAnswer].self, from: data)
                print(myanswer.count)
               
                compi(myanswer)
                
                
            }catch {
                let error = error
                print(error)
                
            }
        }.resume()
        
        
    }
    
    @objc private func presentSharesheet(){
        guard  let image = UIImage(systemName: "bell"),let url = URL(string: "https://google.com") else {
            return
        }
        let sharesheetVc = UIActivityViewController(activityItems: [image,url], applicationActivities: nil)
    present(sharesheetVc, animated: true)
}

    
    @IBAction func shareAction(_ sender: Any) {
        presentSharesheet()
     
    }
    
    
    @IBAction func PostAnswerSegue(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AnswerPost") as? AnswerPost
        vc?.post_id = postData.post_id
        vc?.question = postData.post
        self.navigationController?.pushViewController(vc!, animated: true)
        
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        ProfileLogo.image = UIImage(named: "\(Int.random(in: 0...12))")
        userId.text = "Posted BY \( postData.user_id ?? "")\n\n"
        QuestionLabel.text = "\(postData.post ?? "")\n"
        ProfileLogo.contentMode = .scaleAspectFill
        ProfileLogo.clipsToBounds = true
        ProfileLogo.layer.cornerRadius = 20
        AnswerButton.layer.cornerRadius = 5
        ShareButton.layer.cornerRadius = 5
        ShareButton.clipsToBounds = true
        AnswerButton.clipsToBounds = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        
        let url = "https://firebase-function-api.herokuapp.com/comment/?type=answer&p_commentid=\(postData.post_id ?? "")"
        
        fetchPostData(url: url, compi: {
            (data) in
            self.myanswer = data
            DispatchQueue.main.async {
                if self.myanswer?.count != 0 {
                    self.AnswerList.text =  "Number of answers = \(self.myanswer?.count)"
                }else{
                    self.AnswerList.text = "Be the first one to answer"
                }
                
               self.tableView.reloadData()

            }

        })
        
       
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
