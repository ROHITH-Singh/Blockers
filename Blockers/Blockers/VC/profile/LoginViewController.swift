//
//  LoginViewController.swift
//  Blockers
//
//  Created by Rohit on 22/05/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    let defaults  = UserDefaults.standard
    var email:String = ""
    var Password:String = ""
    var FType:String = ""
    @IBOutlet weak var Email: UITextField!
   
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email = Email.text ?? ""
        Password = password.text ?? ""

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ForgotPassword(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ResetViewController") as? ResetViewController
      self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func LoginTaped(_ sender: Any) {
        if email != nil && password != nil {
            print(email)
            print(password)
            GetLogin()
            
        }
    }
    
    func GetLogin(){
        let url = "https://firebase-function-api.herokuapp.com/user/login"
        let json = ["email" : "\(Email.text ?? "")" , "password" : "\(password.text ?? "")"]
        print(json)
        let urlString = URL.init(string: url)
        Alamofire.request("https://firebase-function-api.herokuapp.com/user/login",method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in
                  print(response.request)  // original URL request
                  print(response.response) // URL response
                  print(response.data)     // server data
                  print(response.result)   // result of response serialization

                  if let JSON1 = response.result.value {
                    print("JSON: \(JSON1)")
                    let data = JSON(JSON1)
                    if data["message"] == "true"{
                        print(data["user"]["user_id"])
                        self.defaults.set("\(data["user"]["user_id"])",forKey: "user_id")
                        self.defaults.set("\(data["user"]["name"])",forKey: "name")
                        self.defaults.set("\(data["user"]["email"])",forKey: "email")
                        self.defaults.set(true,forKey: "login")
//                                   let vc = self.storyboard?.instantiateViewController(identifier: "profile") as? profile
//                                 self.navigationController?.pushViewController(vc!, animated: true)
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                   else if data["message"] != "true" {
                        self.FType = "\(data["type"])"
                        self.showAlert()
                        
                    }
                    
                  }
                    
                  response.result.error
              }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "failure", message: "\(FType)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "0K", style: .default, handler: { action in
          
//           let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
//          self.navigationController?.pushViewController(vc!, animated: true)
           
        }))
        present(alert, animated: true)
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
