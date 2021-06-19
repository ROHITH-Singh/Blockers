//
//  SignupViewController.swift
//  Blockers
//
//  Created by Rohit on 14/06/21.
//

import UIKit
import Alamofire
import  SwiftyJSON

class SignupViewController: UIViewController {

    var FType:String  = ""
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    @IBAction func signup(_ sender: Any) {
        GetLogin()
    }
    
    func GetLogin(){
        let url = "https://firebase-function-api.herokuapp.com/user/login"
        let json = ["email" : "\(Email.text ?? "")" , "password" : "\(password.text ?? "")", "name" : "\(Name.text ?? "")" ,"password2" : "\(password1.text ?? "")"]
        print(json)
        let name = Name.text ?? ""
        let urlString = URL.init(string: url)
        Alamofire.request("https://firebase-function-api.herokuapp.com/user/register/",method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { response in
                  print(response.request)  // original URL request
                  print(response.response) // URL response
                  print(response.data)     // server data
                  print(response.result)   // result of response serialization

                  if let JSON1 = response.result.value {
                    print("JSON: \(JSON1)")
                    let data = JSON(JSON1)
                    
                   
                    if data[0]["name"].stringValue == "\(self.Name.text ?? "")" {
                        self.FType = "\(data[0]["name"]) \n Please Login Ur registered"
                        self.showAlert1()
                                   
                    
                    }
                        
                   
                    else{
                        self.FType = "\(data[0]["message"] )\n\(data[1]["message"] ?? "")\n\(data[2]["message"] ?? "" )\n\(data[3]["message"] ?? "")"
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
            let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
          self.navigationController?.pushViewController(vc!, animated: true)
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
