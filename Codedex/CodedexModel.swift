//
//  CodedexModel.swift
//  Codedex
//
//  Created by Annie Ritch on 9/21/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import Foundation
import UIKit

var app_id = "3a"
var app_key = "4"

class CodedexModel {
    
    
    
    static func encodeImage(image: UIImage) -> String {
        let imageData: NSData = UIImagePNGRepresentation(image)!
        let strBase64: String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
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
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["image":encodedImage, "gallery_name":"allFaces", "subject_id":andId], options: .PrettyPrinted)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
                task.resume()
            } catch {
                print("Something went wrong! \(error)")
            }
        }
    }
    
}
