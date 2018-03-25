//
//  LogIn.swift
//  MedTime
//
//  Created by alden lamp on 3/24/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation
import UIKit

class LogIn: UIViewController{
    
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var logInButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)

//        userName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.aldenTextColor])
//        userName.attributedText = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.aldenTextColor])
//        userName.font = UIFont(name: "Avenir-Medium", size: 21)
        
        userName.textColor = UIColor.aldenTextColor
        userName.layer.borderColor = UIColor.aldenTextColor.cgColor
        userName.layer.borderWidth = 3
        userName.layer.cornerRadius = 8
        userName.layer.masksToBounds = true
        
        
        
//        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.aldenTextColor])
//        password.font = UIFont(name: "Avenir-Medium", size: 21)
//        password.textColor = UIColor.aldenTextColor
        password.layer.borderColor = UIColor.aldenTextColor.cgColor
        password.layer.borderWidth = 3
        password.layer.cornerRadius = 8
        password.layer.masksToBounds = true
        password.isSecureTextEntry = true
        
        
        logInButton.layer.borderWidth = 3
        logInButton.layer.borderColor = UIColor.aldenTextColor.cgColor
        logInButton.layer.cornerRadius = 8
        logInButton.layer.masksToBounds = true
//        0x103611e50
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func logIn(_ sender: Any) {
        if userName.text == "" || password.text == ""{
            alert(title: "Invalid log in", message: "please make sure to have a username and password") {}
            return
        }
        
        
    }
    
}



extension UIColor{
    
    static var aldenLightText = UIColor(hex: "798CAD", alpha: 1)
    static var aldenTextColor = UIColor(hex: "55596B", alpha: 1)
    static var aldenDarkText = UIColor(hex: "3D4C68", alpha: 1)
    
    convenience init (hex: String, alpha: CGFloat){
        let cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if ((cString.count) != 6) {  }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}


extension UIFont{
    
    static var header = UIFont(name: "Avenir-Heavy", size: 23.5)
    static var title = UIFont(name: "Avenir-Medium", size: 21)
    static var body = UIFont(name: "Avenir-Book", size: 19)
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIViewController{
    
    func alert(title: String, message: String, buttonTitle: String = "Okay", completion: @escaping () -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: .default, handler: {(handler) in
            alert.dismiss(animated: true, completion: nil)
            completion()
        })
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
