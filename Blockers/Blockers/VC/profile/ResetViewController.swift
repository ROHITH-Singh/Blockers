//
//  ResetViewController.swift
//  Blockers
//
//  Created by Rohit on 14/06/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ResetViewController: UIViewController {
    

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var FType:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Reset(_ sender: Any) {
        GetReset()
    }
    
    func GetReset(){
        let url = "https://firebase-function-api.herokuapp.com/user/reset/"
        let json = ["email" : "\(email.text ?? "")" , "password" : "\(password.text ?? "")"]
        print(json)
        let urlString = URL.init(string: url)
        Alamofire.request("https://firebase-function-api.herokuapp.com/user/reset/",method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in
                  print(response.request)  // original URL request
                  print(response.response) // URL response
                  print(response.data)     // server data
                  print(response.result)   // result of response serialization

                  if let JSON1 = response.result.value {
                    print("JSON: \(JSON1)")
                    let data = JSON(JSON1)
                    if data["message"].stringValue == "true"{
                        self.FType = "\(data["type"])"
                        self.showAlert1()
                                 
                    }
                    
                    else if data["message"].stringValue != "true" {
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

    
    func showAlert1() {
        let alert = UIAlertController(title: "Success", message: "\(FType)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "0K", style: .default, handler: { action in
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController
          self.navigationController?.pushViewController(vc!, animated: true)

        }))
        present(alert, animated: true)
    }



}
