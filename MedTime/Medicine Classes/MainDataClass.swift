//
//  MainDataClass.swift
//  HackNYU
//
//  Created by alden lamp on 3/24/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import Foundation

struct Settings{
    public static var allowsSharingData = true
    public static var allowsMotionSensing = true
    public static var timeForMotionSensing = 4
    public static func saveNewResults(privacy: Bool, sensing: Bool, time: Int){
        allowsSharingData = privacy
        allowsMotionSensing = sensing
        timeForMotionSensing = time
    }
}

class MainDataClass{
    
    var userId: Int!
    var medication = [MedicineData]()
    
    init() {
//        getCurrentUserData()
        logIn(userName: "alexmweiss2@gmail.com", password: "password")
    }
    
    
    //MARK: - Get current User Data
//
//    func getCurrentUserData(){
//
//        //http://35.231.38.194/<FUNCTION>
//        //Always Post
//        /*
//        LogIn (username, password)
//            Body = "username=asdf&password=password"
//            return = (User ID, Token)
//         getinfo
//            Body = (userid, token)
//            return user
//        logemergency
//            Body = (userid, token, latitude, longitude)
//        */
//
//        let requestURL = "https://us-central1-late-pass-lab.cloudfunctions.net/app/request"
//        var request = URLRequest(url: URL(string: requestURL)!)
//        request.httpMethod = "GET"
////        request.addValue("application/json", forHTTPHeaderField: "Content-type")
////        request.addValue(token!, forHTTPHeaderField: "Authorization")
//
//
////        //TODO: - Multi Person Pass
//
//
//        request.httpBody = "{}".data(using: String.Encoding.utf8)
//
////      request.httpBody = "{\"origin\":\"\(origin)\",\"student\":\(firebaseData.currentUser.userType != .student ? "" : "\"")\(student)\(firebaseData.currentUser.userType != .student ? "" : "\""),\"reason\":\"\(reasoning)\"}".data(using: String.Encoding.utf8)
//
//        print(String(data: request.httpBody!, encoding: String.Encoding.utf8)!)
//
//        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, _) in
//
//            let responseMessage: String = String(data: data!, encoding: String.Encoding.utf8)!
//            print("\nData: \(responseMessage) \n\n")
//
//            if let httpResponse = response as? HTTPURLResponse { print("response: \(httpResponse.statusCode)\n") }
//            if let httpResponse = response as? HTTPURLResponse { print("response: \(httpResponse)\n\n") }
//
//        }).resume()
//
//    }
    
    func logIn(userName: String, password: String){
        let requestURL = "http://35.231.38.194/login"
        var request = URLRequest(url: URL(string: requestURL)!)
        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
//        request.httpBody = "{\"username\":\"\(userName)\"&\"password\":\"\(password)\"}".data(using: String.Encoding.utf8)
        request.httpBody = "username=\(userName)&password=\(password)".data(using: String.Encoding.utf8)

        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, _) in
            let responseMessage: String? = String(data: data!, encoding: String.Encoding.utf8)
            print("\n")
            print(responseMessage)
            print("\n")
            if let httpResponse = response as? HTTPURLResponse { print("response: \(httpResponse.statusCode)\n") }
            print("\n")
            if let httpResponse = response as? HTTPURLResponse { print("response: \(httpResponse)\n\n") }
            
        }).resume()
    }

    
    //MARK: - Get All Users
    
    
    
    
    //MARK: - Get All Appointments
    
    

    
    
    
    
    
    
    
    
}
