//
//  ExpandedMedicineViewController.swift
//  MedTime
//
//  Created by alden lamp on 3/25/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation
import UIKit

protocol ExpandMedicineDelegate: class{
    func reloadTableView()
}

class ExpandedMedicineViewController: UIViewController{
    
    var data: MedicineData!
    
    @IBOutlet var formalName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var brandName: UILabel!
    @IBOutlet var dosage: UILabel!
    @IBOutlet var forTreatmentOf: UILabel!
    @IBOutlet var button: UIButton!
    
    weak var delegate: ExpandMedicineDelegate!
    
    @IBAction func takePill(_ sender: Any) {
        data.takePill()
        delegate.reloadTableView()
        cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor(hex: "A50085", alpha: 1).cgColor
        button.layer.borderWidth = 2
        
        formalName.text = data.displayName
        brandName.text = "Brand Name: \(data.brandName)"
        dosage.text = "Dosage: \(data.dosage)mL"
        setUpCancelButton()
        //TODO: - create a Treatment
        //            forTreatmentOf.text = "For Treatment Of: \(data.treatment)"
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
