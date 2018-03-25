//
//  TimerViewController.swift
//  MedTime
//
//  Created by alden lamp on 3/25/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation
import UIKit

class TimerViewController: UIViewController{
    
    var totalTime: Int!
    private var timeInSecconds = 0{
        didSet{
            timeLabel.text = String(timeInSecconds)
        }
    }
    
    private var startTime = 0
    
    private var titleLabel = UILabel()
    private var timeLabel = UILabel()
    private var button = UIButton()
    private var contactButton = UIButton()
    
    private var timer = Timer()
    
    
    override func viewDidLoad() {
        timeInSecconds = 60 * totalTime
        view.backgroundColor = UIColor.white
        let background = UIImageView()
        background.image = #imageLiteral(resourceName: "background")
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -2).isActive = true
        background.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -2).isActive = true
        background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 2).isActive = true
        background.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 2).isActive = true
        background.alpha = 1
        
        titleLabel.text = "TIMER TO ALERT POLICE"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 24)
        titleLabel.textColor = UIColor.aldenDarkText
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setUpContactSooner()
        
        contactButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        
        
        self.view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.contactButton.bottomAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        timeLabel.text = String(timeInSecconds)
        timeLabel.font = UIFont(name: "Avenir-Heavy", size: 140)
        timeLabel.textColor = UIColor.aldenDarkText
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(timeLabel)
        
        timeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        
//        timer = Timer(timeInterval: TimeInterval.init(1), target: self, selector: #selector(timerInterval), userInfo: nil, repeats: false)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerInterval), userInfo: nil, repeats: true)
        timer.fire()
        
        button.setTitle("DISABLE", for: .normal)
        button.setTitleColor(UIColor.aldenDarkText, for: .normal)
        button.layer.borderColor = UIColor.aldenDarkText.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 30)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        button.addTarget(self, action: #selector(dissableButton), for: .touchUpInside)
    }
    
    func setUpContactSooner(){
        contactButton.setTitle("CONTACT", for: .normal)
        contactButton.setTitleColor(UIColor.aldenDarkText, for: .normal)
        contactButton.layer.borderColor = UIColor.aldenDarkText.cgColor
        contactButton.layer.borderWidth = 3
        contactButton.layer.cornerRadius = 8
        contactButton.layer.masksToBounds = true
        contactButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 30)
        
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contactButton)
        
        contactButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        contactButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        contactButton.addTarget(self, action: #selector(contactPolice), for: .touchUpInside)
    }
    
    @objc func dissableButton(){
        timer.invalidate()
        NotificationCenter.default.post(name: Notifications.phoneDroppedDismissed, object: nil, userInfo: nil)
    }
    
    @objc func timerInterval(){
        startTime += 1
        timeInSecconds = (60 * totalTime) - startTime
        if timeInSecconds == 0{
            contactPolice()
        }
    }
    
    @objc func contactPolice(){
        timer.invalidate()
        alert(title: "Police Contacted", message: "The Police has been contacted with your location", completion: {
            NotificationCenter.default.post(name: Notifications.phoneDroppedDismissed, object: nil, userInfo: nil)
        })
    }
    
    
    
}
