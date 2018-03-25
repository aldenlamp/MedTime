//
//  MedicineTableViewCell.swift
//  HackNYU
//
//  Created by alden lamp on 3/24/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation
import UIKit


protocol MedicineCellDelegate: class{
    func reloadTableView()
}

class MedicineCell: UITableViewCell{
    private var userImageView = UIImageView()
    private var pillName = UILabel()
    private var otherPillName = UILabel()
    private var nextTime = UILabel()
    private var takeButton = UIButton()
    private var dosageLabel = UILabel()
    private var data: MedicineData!
    
    weak var delegate: MedicineCellDelegate!
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpImageView()
        getTextView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    private func setUpImageView(){
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(userImageView)
        
        userImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        userImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 5).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor, constant: 0).isActive = true
        
        //Default Image
        userImageView.image = #imageLiteral(resourceName: "icons8-pill")
    }
    
    func includesTake(_ take: Bool){
        if take{
            takeButton.isHidden = false
            nextTime.isHidden = true
        }else{
            takeButton.isHidden = true
            nextTime.isHidden = false
        }
    }
    
    
    private func getTextView(){
        let finalTextView = UIView()
        
        let titleLabel = setUpTitleLabel()
        let dosageAndTime = setUpDateAndTime()
        
        
        finalTextView.addSubview(titleLabel)
        finalTextView.widthAnchor.constraint(lessThanOrEqualToConstant: self.frame.width).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: finalTextView.topAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: finalTextView.leftAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: finalTextView.rightAnchor, constant: 0).isActive = true
        
        finalTextView.addSubview(dosageAndTime)
        dosageAndTime.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        dosageAndTime.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0).isActive = true
        dosageAndTime.rightAnchor.constraint(equalTo: finalTextView.rightAnchor, constant: 0).isActive = true
        
        finalTextView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(finalTextView)
        finalTextView.heightAnchor.constraint(equalToConstant: 47).isActive = true
        finalTextView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        finalTextView.leftAnchor.constraint(equalTo: self.userImageView.rightAnchor, constant: 10).isActive = true
        finalTextView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
    }
    
    
    private func setUpTitleLabel() -> UIView{
        
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        titleView.addSubview(pillName)
        pillName.adjustsFontSizeToFitWidth = true
        pillName.translatesAutoresizingMaskIntoConstraints = false
        pillName.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0).isActive = true
        pillName.leftAnchor.constraint(equalTo: titleView.leftAnchor, constant: 0).isActive = true
        pillName.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 0).isActive = true
        pillName.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        
        pillName.textColor = UIColor.aldenTextColor
        pillName.font = UIFont.title
        
        pillName.textAlignment = .left
        
        otherPillName.textAlignment = .right
        otherPillName.adjustsFontSizeToFitWidth = true
        
        otherPillName.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(otherPillName)
        otherPillName.rightAnchor.constraint(equalTo: titleView.rightAnchor, constant: 0).isActive = true
        otherPillName.leftAnchor.constraint(equalTo: pillName.rightAnchor, constant: 30).isActive = true
        otherPillName.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0).isActive = true
        otherPillName.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 0).isActive = true
        
        return titleView
    }
    
    
    
    private func setUpDateAndTime() -> UIView{
        let dosage = UIView()
        dosage.translatesAutoresizingMaskIntoConstraints = false
        
        let dosageIcon = UIImageView()
        dosageIcon.translatesAutoresizingMaskIntoConstraints = false
        dosageIcon.image = #imageLiteral(resourceName: "icons8-prescription_pill_bottle")
        dosageIcon.heightAnchor.constraint(equalToConstant: 19).isActive = true
        dosageIcon.widthAnchor.constraint(equalToConstant: 17).isActive = true
        
        dosage.addSubview(dosageIcon)
        
        dosageIcon.topAnchor.constraint(equalTo: dosage.topAnchor, constant: 0.5).isActive = true
        dosageIcon.bottomAnchor.constraint(equalTo: dosage.bottomAnchor, constant: -0.5).isActive = true
        dosageIcon.leftAnchor.constraint(equalTo: dosage.leftAnchor, constant: 0).isActive = true
        
        dosageLabel.translatesAutoresizingMaskIntoConstraints = false
        dosageLabel.textColor = UIColor(hex: "1A42F2", alpha: 1)
        dosageLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        dosageLabel.adjustsFontSizeToFitWidth = true
        
        dosage.addSubview(dosageLabel)

        dosageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dosageLabel.rightAnchor.constraint(equalTo: dosage.rightAnchor, constant: 0).isActive = true
        dosageLabel.topAnchor.constraint(equalTo: dosage.topAnchor, constant: 0).isActive = true
        dosageLabel.bottomAnchor.constraint(equalTo: dosage.bottomAnchor, constant: 0).isActive = true
        NSLayoutConstraint(item: dosageLabel, attribute: .left, relatedBy: .equal, toItem: dosageIcon, attribute: .right, multiplier: 1, constant: 5).isActive = true
        

        nextTime.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nextTime.translatesAutoresizingMaskIntoConstraints = false
        nextTime.textColor = UIColor(hex: "A50085", alpha: 1)
        nextTime.font = UIFont(name: "Avenir-Medium", size: 15)
        nextTime.textAlignment = .right
        nextTime.adjustsFontSizeToFitWidth = true

        let fullView = UIView()
        fullView.addSubview(dosage)
        fullView.addSubview(nextTime)
        fullView.translatesAutoresizingMaskIntoConstraints = false
        fullView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        dosage.leftAnchor.constraint(equalTo: fullView.leftAnchor, constant: 0).isActive = true
        dosage.topAnchor.constraint(equalTo: fullView.topAnchor, constant: 0).isActive = true
        dosage.bottomAnchor.constraint(equalTo: fullView.bottomAnchor, constant: 0).isActive = true
        dosage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        nextTime.rightAnchor.constraint(equalTo: fullView.rightAnchor, constant: 0).isActive = true
        nextTime.leftAnchor.constraint(equalTo: dosage.rightAnchor, constant: 8).isActive = true
        nextTime.bottomAnchor.constraint(equalTo: fullView.bottomAnchor, constant: 0).isActive = true
        nextTime.topAnchor.constraint(equalTo: fullView.topAnchor, constant: 0).isActive = true
        
        takeButton.translatesAutoresizingMaskIntoConstraints = false
        takeButton.layer.borderColor = UIColor(hex: "A50085", alpha: 1).cgColor
        takeButton.layer.borderWidth = 1
        takeButton.layer.cornerRadius = 8
        takeButton.layer.masksToBounds = false
        takeButton.setTitle("Take", for: .normal)
         takeButton.setTitleColor(UIColor(hex: "A50085", alpha: 1), for: .normal)
        takeButton.titleLabel?.font = UIFont(name: "Avneir-Medium", size: 19)
        takeButton.addTarget(self, action: #selector(takeButtonPressed), for: .touchUpInside)
        
        fullView.addSubview(takeButton)
        takeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        takeButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        takeButton.centerYAnchor.constraint(equalTo: fullView.centerYAnchor, constant: 0).isActive = true
        takeButton.rightAnchor.constraint(equalTo: fullView.rightAnchor, constant: -8).isActive = true
        
        
        return fullView
        
    }
    
    @objc public func takeButtonPressed(){
        data.takePill()
        delegate.reloadTableView()
    }
    
    public func reloadTableView(){
        delegate.reloadTableView()
    }
    
    //MARK: - Update Functions
    
    func createFrom(data: MedicineData){
        self.data = data
        self.pillName.text = data.displayName
        self.dosageLabel.text = "Dosage: \(data.dosage)mL"
        self.otherPillName.text = "Brand Name: \(data.brandName)"
        
        let date = Date().addingTimeInterval(TimeInterval(data.frequency))
        let currentDate = Date()
        
        let cal = Calendar.current
        
        let day1 = cal.component(.day, from: date)
        let day2 = cal.component(.day, from: currentDate)
        
        let hour = cal.component(.hour, from: date)
        let hour2 = cal.component(.hour, from: currentDate)
        
        if day1 == day2{
            let hourDif = hour - hour2
            self.nextTime.text = "Next Time: \(hourDif)hrs"
        }else{
            let dayDiff = day1 - day2
            self.nextTime.text = "Next Time: \(dayDiff)days"
        }

    }
    
}
