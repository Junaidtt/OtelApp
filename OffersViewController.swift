//
//  OffersViewController.swift
//  OtelApp
//
//  Created by sunil v g  on 17/06/17.
//  Copyright © 2017 Qvertz Technologies. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
import SwiftyJSON

class OffersViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var offerTableView: UITableView!

    var offers = [[String:AnyObject]]()
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
             self.fetchOfferDetails()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(fetchOfferDetails), for: UIControlEvents.valueChanged)
        offerTableView.addSubview(refresher)
        
       
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as! OfferTableViewCell
        
        
        let dict = offers[indexPath.row]
        // cell.nameText?.text = dict["name"] as? String
        
        print(dict)
        let imageOffer = dict["Image"] as? String
        let remoteImageURL=AppConfig.linkToServer+"ImageAPI/"+imageOffer!+"/"
        let imageUrl = NSURL(string:remoteImageURL)
        print(imageUrl)
        
        cell.offerLabel.text = dict["OfrText"] as? String
        
        cell.offerImage.sd_setImage(with: imageUrl as URL!)
        
        return cell
        
    

    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = .clear
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }


    
    func fetchOfferDetails()  {
        
        
        SVProgressHUD.show()
        
        let url = URL(string: "http://132.148.22.59:7575/api/offerAPI/00003")
        
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
                                
                                self.offers = resData as! [[String : AnyObject]]
                                print(item)
                                print(self.offers)
                            }
                        }
                        DispatchQueue.main.async (execute: { () -> Void in
                       
                            if self.offers.count > 0 {
                                self.offerTableView.reloadData()
                            }
                            
                            SVProgressHUD.dismiss()
                            self.refresher.endRefreshing()
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
    
}
