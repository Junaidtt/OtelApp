//
//  ProfileViewController.swift
//  OtelApp
//
//  Created by sunil v g  on 22/06/17.
//  Copyright © 2017 Qvertz Technologies. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var profileImage: UIImageView!
    
    var profileDetails = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 2
        profileImage.layer.cornerRadius = 60
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
        
}
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.profileDetails[indexPath.row]
        
        return cell
   }

    
}
