                                                                   //
//  MainNavigationController.swift
//  HackNYU
//
//  Created by alden lamp on 3/23/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    fileprivate var observers = [NSObjectProtocol]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.isNavigationBarHidden = false
        addObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        observers.forEach{ NotificationCenter.default.removeObserver($0) }
    }
    
    
    //MARK: - NavigationItem

//    leftMenuButton: (#imageLiteral(resourceName: "icons8-menu_filled"), 23, 20)
//        rightPlusButton: (25, 25)
    
    func createBarButtonWith(image : UIImage, height: CGFloat, width: CGFloat) -> UIButton{
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1).isActive = true
        
        let imageView = UIImageView()
        button.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image.withRenderingMode(.alwaysOriginal)
        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor, constant: 0).isActive = true
        return button
    }
    
    public func setUpNavigationShadow(){
        self.navigationBar.backgroundColor = UIColor.white
        self.navigationBar.layer.borderColor = UIColor.white.cgColor
        self.navigationBar.layer.borderWidth = 0
        self.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationBar.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.navigationBar.layer.shadowRadius = 1
        self.navigationBar.layer.shadowOpacity = 0.3
    }
    
    @objc func openSideBar(){
        NotificationCenter.default.post(Notification(name: Notifications.shouldToggleMenu, object: self))
    }
    
    
    
    //MARK: - Switch View Observers
    
    func addObservers(){
        let notificationCenter = NotificationCenter.default
        let observers: [Notification.Name] = [Notifications.shouldSwitchToHome, Notifications.shouldSwitchToSettings, Notifications.shouldSwitchToMedicine, Notifications.shouldSwitchToDetails]
        
        for observerTitle in observers{
            print(observerTitle.rawValue)
            let observer: NSObjectProtocol = notificationCenter.addObserver(forName: observerTitle, object: nil, queue: nil, using: { [weak self] (notification) in
                if notification.name.rawValue == Notifications.NavigationNotifications.details.rawValue{
                    self?.switchViewTo(UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Details"))
                    
                }else{
                    self?.switchViewTo(Notifications.notificationToViewController[notification.name.rawValue]!.init())
                }
            })
            self.observers.append(observer)
        }
    }
    
    func switchViewTo(_ viewController: UIViewController){
        setViewControllers([viewController], animated: false)
    }
    
}

