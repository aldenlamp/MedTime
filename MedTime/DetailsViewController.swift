//
//  File.swift
//  MedTime
//
//  Created by alden lamp on 3/24/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
    }
    
    func setUpNavigation(){
        let navController = (navigationController as! MainNavigationController)
        
//        let rightSettingsButton: UIButton = navController.createBarButtonWith(image: #imageLiteral(resourceName: "icons8-settings_filled"), height: 25, width: 25)
//        rightSettingsButton.addTarget(self, action: #selector(toggleSettings), for: .touchUpInside)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightSettingsButton)
        
        let leftMenuButton: UIButton = navController.createBarButtonWith(image: #imageLiteral(resourceName: "icons8-menu_filled"), height: 25, width: 25)
        leftMenuButton.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftMenuButton)
        
        let title: UILabel = UILabel()
        title.text = "Details"
        title.textColor = UIColor(hex: "299BE6", alpha: 1)
        title.font = UIFont(name: "Avenir-Heavy", size: 21)
        title.textAlignment = .center
        
        navigationItem.titleView = title
    }
    
//    @objc func toggleSettings(){
//        let vc = SettingsViewController()
//        self.present(vc, animated: true, completion: nil)
//    }
    
    @objc func toggleMenu(){ NotificationCenter.default.post(name: Notifications.shouldToggleMenu, object: nil) }
    
    
}
