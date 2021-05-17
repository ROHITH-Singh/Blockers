//
//  AnswerViewController.swift
//  Blockers
//
//  Created by Rohit on 17/05/21.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var postData: MyPost!

    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var AnswerButton: UIButton!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var ProfileLogo: UIImageView!
    @IBOutlet weak var userId: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileLogo.image = UIImage(named: "\(Int.random(in: 0...12))")
        userId.text = "Posted BY \( postData.user_id ?? "")"
        QuestionLabel.text = "\(postData.post ?? "")"
        ProfileLogo.contentMode = .scaleAspectFill
        ProfileLogo.clipsToBounds = true
        ProfileLogo.layer.cornerRadius = 20
        AnswerButton.layer.cornerRadius = 5
        ShareButton.layer.cornerRadius = 5
        ShareButton.clipsToBounds = true
        AnswerButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
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
