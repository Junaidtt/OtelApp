//
//  CheckInViewController.swift
//  OtelApp
//
//  Created by sunil v g  on 16/06/17.
//  Copyright © 2017 Qvertz Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD

class CheckInViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var checkIntextField: UITextField!

    @IBOutlet weak var checkInFrame: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

   
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
  
    @IBAction func checkInButtonTapped(_ sender: AnyObject) {
        
        if checkIntextField.text != ""{
         
            SVProgressHUD.show(withStatus: "Checkin...")
            
            
            let syn = AsynUser(view: self)
            DispatchQueue.global(qos: .userInitiated).async {
                
            syn.checkInUser()
                            }
            
        }
        
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
