//
//  ViewController.swift
//  OtelApp
//
//  Created by sunil v g  on 15/06/17.
//  Copyright © 2017 Qvertz Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
    }

  
    @IBAction func loginButtonTapped(_ sender: AnyObject) {
        
        var user : Struct_User = Struct_User()
        user.email = phoneTextField.text
        user.password = passwordTextField.text
        
        SVProgressHUD.show()
        
        
        
        if phoneTextField.text != "" && passwordTextField.text != ""{
        
          SVProgressHUD.show()
            
            let syn = AsynUser(view: self,user: user)
            DispatchQueue.global(qos: .userInitiated).async {
                
                syn.login()
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
















