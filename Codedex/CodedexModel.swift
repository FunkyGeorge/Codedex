//
//  CodedexModel.swift
//  Codedex
//
//  Created by Annie Ritch on 9/21/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import Foundation
import UIKit

//TAKE THESE OUT BEFORE GITHUB
var app_id = ""  //insert id
var app_key = "" //insert key

class CodedexModel {
    
    
    
    static func encodeImage(image: UIImage) -> String {
        let imageData = UIImageJPEGRepresentation(image, 1.0)!  //changed this to JPEG from PNG
        //let strBase64: String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        let strBase64 = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0)) // new base64 encoding
        return strBase64
    }
    
    static func submitImageForRecognition(image: UIImage, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        if let urlToReq = NSURL(string: "https://api.kairos.com/recognize") {
            let request = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(app_id, forHTTPHeaderField: "app_id")
            request.setValue(app_key, forHTTPHeaderField: "app_key")
            do {
                let encodedImage = encodeImage(image)
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["image":encodedImage, "gallery_name":"allFaces"], options: .PrettyPrinted)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
                task.resume()
            } catch {
                print("Something went wrong! \(error)")
            }
        }
    }
    
    static func submitImageForEnrollment(image: UIImage, andId: String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        if let urlToReq = NSURL(string: "https://api.kairos.com/enroll") {
            let request = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(app_id, forHTTPHeaderField: "app_id")
            request.setValue(app_key, forHTTPHeaderField: "app_key")
            do {
                let encodedImage = encodeImage(image)
                //let encodedImage = ""
                //print(encodedImage)
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["image":encodedImage, "gallery_name":"allFaces", "subject_id":andId, "selector": "SETPOSE"], options: .PrettyPrinted)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
                task.resume()
            } catch {
                print("Something went wrong! \(error)")
            }
        }
    }
    
}
