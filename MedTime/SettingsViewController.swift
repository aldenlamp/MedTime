//
//  SettingsViewController.swift
//  MedTime
//
//  Created by alden lamp on 3/24/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation
import UIKit


class SettingsViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet var privacy: UISwitch!
    @IBOutlet var motionSensing: UISwitch!
    @IBOutlet var timeForMotionSensing: UITextView!
    @IBOutlet var logOutImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setUpCancelButton()
        
        timeForMotionSensing.delegate = self
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(logOut))
        recognizer.minimumPressDuration = 0.1
        logOutImage.addGestureRecognizer(recognizer)
        
        privacy.setOn(Settings.allowsSharingData, animated: false)
        motionSensing.setOn(Settings.allowsMotionSensing, animated: false)
        timeForMotionSensing.text = String(Settings.timeForMotionSensing)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == nil || textView.text == "" {
            Settings.timeForMotionSensing = 0
            return
        }
        if textView.text.contains("\n"){
            textView.resignFirstResponder()
            textView.text.removeLast()
        }
        Settings.timeForMotionSensing = Int(textView.text!)!
    }
    
    @IBAction func togglePrivacy(_ sender: Any) {
        Settings.allowsSharingData = privacy.isOn
    }
    
    @IBAction func toggleMotinoSensing(_ sender: Any) {
        Settings.allowsMotionSensing = motionSensing.isOn
    }
    
    @objc func logOut(){
        NotificationCenter.default.post(name: Notifications.logOut, object: nil)
    }
    
    
    func setUpCancelButton(){
        let button = UIButton()
        button.image(for: .normal)
        button.setImage(#imageLiteral(resourceName: "icons8-delete_sign_filled"), for: .normal)
        button.frame = CGRect(x: 28, y: 41, width: 21, height: 21)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc private func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
