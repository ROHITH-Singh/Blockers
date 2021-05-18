//
//  AnswerPost.swift
//  Blockers
//
//  Created by Rohit on 17/05/21.
//

import UIKit

class AnswerPost: UIViewController {
    
    @IBOutlet weak var AnswertextFeild: UITextView!
    
    @IBOutlet weak var Cancel: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var Done: UIButton!
    @IBOutlet weak var QuestionLabel: UILabel!
    var Status : Int = 0
    var post_id: String = ""
    var question: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionLabel.text = "\(question)"
        print(post_id)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(with:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        
     

     
 }
    
    
    @IBAction func done(_ sender: Any) {
        var answer = AnswertextFeild.text
        
        
        // Do any additional setup after loading the view.
        
         let json: [String: Any] = ["user_id": "10","comment":"\(answer ?? "")","post_id":"\(post_id)"]

                 let jsonData = try? JSONSerialization.data(withJSONObject: json)

                 // create post request
                 let url = URL(string: "https://firebase-function-api.herokuapp.com/comment/?type=answer&p_commentid=1")! //PUT Your URL
                 var request = URLRequest(url: url)
                 request.httpMethod = "POST"
                 request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
                 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                 // insert json data to the request
                 request.httpBody = jsonData
        
                 let task = URLSession.shared.dataTask(with: request) { data, response, error in
                     guard let data = data, error == nil else {
                         print(error?.localizedDescription ?? "No data")
                         return
                     }
                     if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                             // check for http errors
                             print("statusCode should be 200 \(httpStatus.statusCode)")
                                 
                         self.Status = httpStatus.statusCode
                        
                        DispatchQueue.main.async{
                            if self.Status == 200 {
                                self.showAlert()
                            }
                          
                        }
                        
                                                     }
                   

                         
                     let responseString = String(data: data, encoding: .utf8)
                         print("responseString = \(responseString)")
                     let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                     if let responseJSON = responseJSON as? [String: Any] {
                         print("response = \(responseJSON)") //Code after Successfull POST Request
                     }
                     
                 }
        
        
          
                     
                 task.resume()
     
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height + 16
        
        bottomConstraint.constant = keyboardHeight ?? 0
    
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
 func showAlert() {
     let alert = UIAlertController(title: "\(Status)", message: "Pew PEw \n Posted ", preferredStyle: .alert)
     alert.addAction(UIAlertAction(title: "0K", style: .default, handler: { action in
        self.navigationController?.popViewController(animated: true)
     }))
     present(alert, animated: true)
 }
    
    fileprivate func dismissAndResign() {
        dismiss(animated: true)
        AnswertextFeild.resignFirstResponder()
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
