//
//  ProfileViewController.swift
//  Blockers
//
//  Created by Rohit on 22/05/21.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var posts: UILabel!
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var emailid: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var userid: UILabel!
    @IBOutlet weak var LoginSignup: UIBarButtonItem!
    @IBOutlet weak var logout: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
//       UserDefaults.standard.removeObject(forKey: "login")
        
        if UserDefaults.standard.string(forKey: "login") != nil{
            logout.isHidden = false
            LoginSignup.isEnabled = false
            print("\(UserDefaults.standard.string(forKey: "name"))")
            userid.text = "\(UserDefaults.standard.string(forKey: "user_id") ?? "") "
            name.text = "\(UserDefaults.standard.string(forKey: "name") ?? "") "
            emailid.text = "\(UserDefaults.standard.string(forKey: "email") ?? "") "
            posts.text = "5"
            rank.text = "4"
        
        // Do any additional setup after loading the view.
    }
        else{
            let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            print("login")
        }
    
    }
    
    @IBAction func loginSignup(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
     @IBAction func logOut(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "user_id")
        let vc = storyboard?.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
     }
   

}
