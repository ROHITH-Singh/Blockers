import UIKit



//let name = "ROHIT"
//UserDefaults.standard.set(name,forKey: "name")
//
//if (UserDefaults.standard.string(forKey: "name") != nil){
//    print(name)
//}
//func saveJSON(json: jsonResponse, key:String){
//  if let jsonString = json.rawString() {
//     UserDefaults.standard.setValue(jsonString, forKey: key)
//  }
//}

   func getJSON(_ key: String)-> jsonResponse? {
   var p = ""
   if let result = UserDefaults.standard.string(forKey: key) {
       p = result
   }
   if p != "" {
       if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
           do {
               return try JSON(data: json)
           } catch {
               return nil
           }
       } else {
           return nil
       }
   } else {
       return nil
   }
}
let session = URLSession.shared
        let url = "https://firebase-function-api.herokuapp.com/user/login/"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var params :[String: Any]?
        params = ["email" : "rs9113848@gmail.com", "password" : "Rohit@91138"]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do{
                       
                       let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        print ("data = \(jsonResponse)")
                        if let jsonString = (jsonResponse as AnyObject).rawString() {
                           UserDefaults.standard.setValue(jsonString, forKey: "login")
                         }
                     
                        
                    
                    }catch _ {
                        print ("OOps not good JSON formatted response")
                    }
                }
            })
            task.resume()
        }catch _ {
            print ("Oops something happened buddy")
        }

