//
//  AsyncUser.swift
//  OtelApp
//
//  Created by sunil v g  on 15/06/17.
//  Copyright © 2017 Qvertz Technologies. All rights reserved.
//

import Foundation
import SVProgressHUD

class AsynUser: NSObject {
    
    var view : AnyObject?
    var user : Struct_User?
    var userDefault : UserDefaults?
    
    init(view : AnyObject, user : Struct_User){
        
        self.view = view
        self.user = user
        self.userDefault  = UserDefaults()
    }
    
    init(view : AnyObject) {
        
         self.view = view
    }
    
    func register() {
        
    /*
        // let params = ["name":user!.name!,"email":user!.email!,"password":user!.password!]
        
        let params = ["Name":"zzz","Email":"zzz@gmail.com","PhoneNo":"555555","Password":"55"]
        do {
            
            let opt = try HTTP.POST("http://132.148.22.59:7575/api/MobUserAPI", parameters: params,headers: nil)
            opt.start { response in
                
                let data = response.data
                if response.error == nil {
                    let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("response: \(str)") //prints the HTML of the page
                    let jsonUser = JSONDecoder(data)
                    
                    if jsonUser["Error"].bool
                    {
                        DispatchQueue.main.async(execute: {
                            ()-> Void in
                            IJProgressView.shared.hideProgressView()
                            }
                        )
                        print("Error")
                    }
                    else{
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            
                            self.view!.performSegue(withIdentifier: "segue_to_login", sender: nil)
                            IJProgressView.shared.hideProgressView()
                            
                            print(jsonUser)
                            
                            
                        })
                    }
                }
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
        
        */
        
        
    }
    func login(){
        
        
         let url = URL(string: "http://132.148.22.59:7575/api/MobUserAPI/?PhoneNo=9446320810&Password=123")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil{
                
                print(error?.localizedDescription)
                
            }else{
                
                if let content = data{
                    
                    do
                    {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(myJson)
                        
                       
                    }
                    catch
                    {
                        print("Error:\(error.localizedDescription)")
                    }
                    
                    DispatchQueue.main.async {
                        // Task consuming task has completed
                        // Update UI from this block of code
                       
                        SVProgressHUD.dismiss()
                    }
                    
                    
                }
                
            }
   
        }
        task.resume()
    
    }
    
    
    func checkInUser(){
        
         let url = URL(string: AppConfig.linkToServer+"/CheckInAPI/000031011633")
        
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if (error != nil){
                
                print(error?.localizedDescription)

            }else{
                
                if let content = data{
                    
                    do
                    {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(myJson)
                        
                        
                    }
                    catch
                    {
                        
                    }
                    
                    DispatchQueue.main.async {
                        // Task consuming task has completed
                        // Update UI from this block of code
                         self.view!.performSegue(withIdentifier: "HomeVC", sender: nil)
                        SVProgressHUD.dismiss()
                    }
                    
                    
                }
                
            }
            
        }
        task.resume()

        
        
        
    }
    
    
    
}
