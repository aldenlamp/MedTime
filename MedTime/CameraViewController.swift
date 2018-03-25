//
//  CameraViewController.swift
//  MedTime
//
//  Created by alden lamp on 3/25/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation
import UIKit

class CameraViewController: UIViewController{
    
    let imageView = UIImageView()
    let pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        
    }
    
    
}
