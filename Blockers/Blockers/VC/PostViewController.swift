//
//  PostViewController.swift
//  Blockers
//
//  Created by Rohit on 18/05/21.
//

import UIKit

class PostViewController: UIViewController {

  
    
    @IBOutlet weak var QuestionTextFeild: UITextView!
//    @IBOutlet weak var Cancel: UIButton!
    
    @IBOutlet weak var Cancel: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    //    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var Done: UIButton!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var Done: UIButton!
   
    var Status : Int = 0
    var type : String = "general"
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(with:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        segmentedControl.addTarget(self, action: #selector(handleSegmentedChange), for: .valueChanged)
     

     
 }
    
    
    @IBAction func done(_ sender: Any) {
        var question = QuestionTextFeild.text
        
        
        // Do any additional setup after loading the view.
        
        let json: [String: Any] = ["post": "\(question ?? "")","type": "\(type)","user_id":"10"]

                 let jsonData = try? JSONSerialization.data(withJSONObject: json)

                 // create post request
                 let url = URL(string: "https://firebase-function-api.herokuapp.com/post/")! //PUT Your URL
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
//        let vc = storyboard?.instantiateViewController(identifier: "HomeView") as? HomeView
//       self.navigationController?.pushViewController(vc!, animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height - 40
        
        bottomConstraint.constant = keyboardHeight ?? 0
    
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    
 func showAlert() {
     let alert = UIAlertController(title: "\(Status)", message: "Pew PEw \n Posted ", preferredStyle: .alert)
     alert.addAction(UIAlertAction(title: "0K", style: .default, handler: { action in
        self.QuestionTextFeild.text.removeAll()
        let vc = self.storyboard?.instantiateViewController(identifier: "HomeView") as? HomeView
       self.navigationController?.pushViewController(vc!, animated: true)
        
     }))
     present(alert, animated: true)
 }
    
    fileprivate func dismissAndResign() {
        dismiss(animated: true)
        QuestionTextFeild.resignFirstResponder()
    }
    @objc fileprivate func handleSegmentedChange() {
           print(segmentedControl.selectedSegmentIndex)
           
           switch segmentedControl.selectedSegmentIndex {
           case 0 : type = "general "
                    print(type)
               
           case 1:
                  type = "developments"
                   print(type)
              
          
        case 2: type = "finance"
            print(type)
            
        default:
            type = "general"
            print(type)
        }
        
    }




    
    

}
extension PostViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if Done.isHidden {
            QuestionTextFeild.text.removeAll()
            QuestionTextFeild.textColor = .white

            Done.isHidden = false

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}



