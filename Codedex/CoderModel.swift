//
//  CoderModel.swift
//  Codedex
//
//  Created by Annie Ritch on 9/22/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import Foundation

class CoderModel {
    
    //get a coder
    static func getUserByName(name: String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        let url = NSURL(string: "http://10.0.0.179:7000/name/\(name)")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: completionHandler)
        task.resume()
    }
    
    //add a coder
    static func addUser(name: String, status: String, level: String, specialty: String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        if let urlToReq = NSURL(string: "http://10.0.0.179:7000/names") {
            let request = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["name": name, "status": status, "level": level, "specialty": specialty], options: .PrettyPrinted)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
                task.resume()
            } catch {
                print("Something went wrong! \(error)")
            }
            
        }
    }
    

}