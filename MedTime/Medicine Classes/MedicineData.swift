//
//  MedicineData.swift
//  HackNYU
//
//  Created by alden lamp on 3/24/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation

class MedicineData: Hashable{
    var hashValue: Int {
        get{
            return displayName.hashValue
        }
    }
    
    static func == (lhs: MedicineData, rhs: MedicineData) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var brandName: String
    var displayName: String
    var timeTaken: Int
    var dosage: Int
    var frequency: Int
    
    init(brandName: String, commonName: String, timeTaken: Int, dosage: Int, frequency: Int){
        self.brandName = brandName
        self.displayName = commonName
        self.timeTaken = timeTaken
        self.dosage = dosage
        self.frequency = frequency
    }
    
    func takePill(){
        timeTaken = Int(Date().timeIntervalSince1970)
    }
    
    var shouldTakeNow: Bool { get{
        print("\(brandName)\t\(Int(Date().timeIntervalSince1970))\t\(timeTaken)\t\(frequency)\t\(Int(Date().timeIntervalSince1970) - timeTaken)")
        return !(Int(Date().timeIntervalSince1970) - timeTaken < frequency) } }
}
