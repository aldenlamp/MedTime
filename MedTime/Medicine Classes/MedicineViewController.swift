//
//  MedicineViewController.swift
//  MedTime
//
//  Created by alden lamp on 3/24/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation
import UIKit

class MedicineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MedicineCellDelegate, ExpandMedicineDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var tableView = UITableView()
    var noDataLabel = UILabel()
    
    var imagePickerView = UIImagePickerController()
    
    private var medication = [[MedicineData](), [MedicineData]()]
    
    public var medicationArr = [MedicineData](){
        didSet{
            reloadTableView()
        }
    }
    
    func sortMedicationArr(){
        medication = [[MedicineData](), [MedicineData]()]
        for i in medicationArr{
            medication[i.shouldTakeNow ? 0 : 1].append(i)
        }
        
        print("\n")
        medication[0].forEach{ print($0.brandName) }
        print("\n")
        medication[1].forEach{ print($0.brandName) }
        print("\n")
    }
    
    internal func reloadTableView(){
        sortMedicationArr()
        tableView.reloadData()
        hideViews()
    }
    
    private func hideViews(){
        if medicationArr.isEmpty{
            tableView.isHidden = true
            noDataLabel.isHidden = false
        }else{
            noDataLabel.isHidden = true
            tableView.isHidden = false
        }
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        tableView.register(MedicineCell.self, forCellReuseIdentifier: "Cell")
        
        setUpNoDataLabel()
        reloadTableView()
        setUpNavigationItem()
        
        let one = MedicineData(brandName: "Zoloft", commonName: "Sertline", timeTaken: 1521859940, dosage: 300, frequency: 172800)
        
        let two = MedicineData(brandName: "Zo1loft", commonName: "Sertrline", timeTaken: 1521859940, dosage: 300, frequency: 1728)
        
        let four = MedicineData(brandName: "Zolof2t", commonName: "Sertralasdine", timeTaken: 1521859940, dosage: 300, frequency: 1728)
        
        let five = MedicineData(brandName: "Zo3loft", commonName: "Serastraline", timeTaken: 1521859940, dosage: 300, frequency: 172800)
        
        let three = MedicineData(brandName: "Zolo4ft", commonName: "Sertsraline", timeTaken: 1521859940, dosage: 300, frequency: 172800)
        
        medicationArr = [one, two, three, four, five]
        
        imagePickerView.cameraDevice = .front
        imagePickerView.delegate = self
        
        imagePickerView.allowsEditing = false
        imagePickerView.sourceType = .camera
        
        present(imagePickerView, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            imageView.contentMode = .ScaleAspectFit
            
//            imageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
//        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    func setUpNoDataLabel(){
        noDataLabel = UILabel()
        noDataLabel.text = "You have no Pills"
        noDataLabel.textColor = UIColor.aldenTextColor
        noDataLabel.font = UIFont(name: "Avenir-Medium", size: 25)
        noDataLabel.textAlignment = .center
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(noDataLabel)
        
        noDataLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        noDataLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        noDataLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        noDataLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        noDataLabel.isHidden = true
    }
    
    //MARK: - Navigation
    private func setUpNavigationItem(){
        //        super.title = "MedTime"
        let navController = (navigationController as! MainNavigationController)
        
        let rightSettingsButton: UIButton = navController.createBarButtonWith(image: #imageLiteral(resourceName: "icons8-camera_filled"), height: 30, width: 30)
        rightSettingsButton.addTarget(self, action: #selector(toggleCamera), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightSettingsButton)
        
        let leftMenuButton: UIButton = navController.createBarButtonWith(image: #imageLiteral(resourceName: "icons8-menu_filled"), height: 25, width: 25)
        leftMenuButton.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftMenuButton)
        
        let title: UILabel = UILabel()
        
        title.text = "Medicine"
        title.textColor = UIColor(hex: "299BE6", alpha: 1)
        title.font = UIFont(name: "Avenir-Heavy", size: 21)
        title.textAlignment = .center
        
        navigationItem.titleView = title
    }
    
    @objc func toggleCamera(){
        //TODO: - Show a new camera screen
    }
    
    @objc func toggleMenu(){ NotificationCenter.default.post(name: Notifications.shouldToggleMenu, object: nil) }
    
    
    
    //MARK: - TableView Functions
    
    
    func numberOfSections(in tableView: UITableView) -> Int { return 2 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 50 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        label.textColor = UIColor.aldenDarkText
        label.text = section == 0 ? "Medication To Take Now" : "Other Medication"
        label.adjustsFontSizeToFitWidth = true
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        
        label.backgroundColor = UIColor.white
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0
        label.layer.shadowColor = UIColor.lightGray.cgColor
        label.layer.shadowOffset = CGSize(width: 1, height: 2)
        label.layer.shadowRadius = 1
        label.layer.shadowOpacity = 0.5
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.backgroundColor = UIColor.white
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medication[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = medication[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MedicineCell
        cell.createFrom(data: data)
        cell.includesTake(indexPath.section == 0)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let mStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mStoryboard.instantiateViewController(withIdentifier: "id") as! ExpandedMedicineViewController
        vc.data = medication[indexPath.section][indexPath.row]
        vc.delegate = self
        didMove(toParentViewController: vc)
        present(vc, animated: true, completion: nil)
        
    }
}
