//
//  ViewController.swift
//  Blockers
//
//  Created by Rohit on 22/03/21.
//

import UIKit

class ViewController: UIViewController {

    private var timer: Timer?
    @IBOutlet weak var LogoImage: UIImageView!
    
    @IBOutlet weak var titleImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LogoImage.image = UIImage(named: "logo2")
        titleImage.image = UIImage(named: "title")
        timer = Timer.scheduledTimer(timeInterval: 5, target: self , selector: #selector(segueMethod),userInfo: nil,repeats: false)
//        LogoImage.frame.size.height = 600
//        LogoImage.frame.size.width = 300
//
        // Do any additional setup after loading the view.
        
    }
    
    @objc func segueMethod(){
        performSegue(withIdentifier: "start", sender: self)
    }
  

}

