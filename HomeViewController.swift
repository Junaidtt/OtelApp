//
//  HomeViewController.swift
//  OtelApp
//
//  Created by sunil v g  on 20/06/17.
//  Copyright © 2017 Qvertz Technologies. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON
import SVProgressHUD

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var menu = [[String:AnyObject]]() //Array of dictionary

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchMenuTask()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return menu.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCollectionViewCell
        var dict = menu[indexPath.row]
        //self.categoryCode=dict["ServiceCategoryCode"] as! String
        //print(categoryCode)
        let imageName=dict["Image"] as? String
        let remoteImageURL=AppConfig.linkToServer+"ImageAPI/"+imageName!
        
        let imageUrl = NSURL(string:remoteImageURL)
        
        cell.itemLabel?.text = dict["CategoryName"] as? String
        cell.itemImage.sd_setImage(with: imageUrl as URL!)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picDimension = self.view.frame.size.width / 2.5
        return CGSize(width: picDimension, height: picDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = self.view.frame.size.width / 14.0
        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    }
  
   /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        var dict = menu[indexPath.row]
        //self.categoryCode=dict["ServiceCategoryCode"] as? String
       // print(categoryCode)
    /*
        if(self.categoryCode == "Info"){
            self.performSegue(withIdentifier: "infoVC", sender: self)
        }else{
            self.performSegue(withIdentifier: "subMenuCVC", sender: self)
        }
        */
    }
*/

    func fetchMenuTask(){
        
        
        let url = URL(string: "http://132.148.22.59:7575/api/AvailableCategoryAPI/00003")
        
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
                        let swiftyJsonVar = JSON(myJson)
                        
                        for item in swiftyJsonVar{
                            
                            if let resData = swiftyJsonVar.arrayObject{
                                
                                print(resData)
                                
                                self.menu = resData as! [[String : AnyObject]]
                                print(item)
                                print(self.menu)
                            }
                        }
                        DispatchQueue.main.async (execute: { () -> Void in
                            
                            if self.menu.count > 0 {
                                self.menuCollectionView.reloadData()
                            }
                            
                            SVProgressHUD.dismiss()
                           // self.refresher.endRefreshing()
                        })
                        
                        
                        
                        
                    }
                    catch
                    {
                        print("Error:\(error.localizedDescription)")
                    }
                    
                }
                
            }
            
        }
        task.resume()
        
        
        
    }

    @IBAction func sosButtonTapped(_ sender: AnyObject) {
        
        
        print("SOS called")
    }
        
        
        
        
 }//classs






















