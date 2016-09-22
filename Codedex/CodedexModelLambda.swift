//
//  CodedexModelLambda.swift
//  Codedex
//
//  Created by Annie Ritch on 9/21/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import Foundation
import UIKit

//TAKE OUT BEFORE GITHUB
var album = "allFaces"
var albumkey = "c8b2f35499408f5852336c9b623614efe694e65983e51fa7bd74cea6c2e2d7c3"
//var app_key = "hi"

class CodedexModelLambda {

    
    static func encodeImage(image: UIImage) -> String {
        let imageData: NSData = UIImagePNGRepresentation(image)!
        let strBase64: String = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return strBase64
    }
    
    static func saveImageToFile(image: UIImage) {
        let documentsDirectoryURL = try! NSFileManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        // create a name for your image
        let fileURL = documentsDirectoryURL.URLByAppendingPathComponent("face_image.png")
        //automatically overwrites
        if UIImagePNGRepresentation(image)!.writeToFile(fileURL.path!, atomically: true) {
            print("file saved")
        } else {
            print("error saving file")
        }
    }
    
        
//    static func submitImageForRecognition(image: UIImage, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
//        if let urlToReq = NSURL(string: "https://api.kairos.com/recognize") {
//            let request = NSMutableURLRequest(URL: urlToReq)
//            request.HTTPMethod = "POST"
//            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//            request.setValue("405111b99cafc94ee4ef79f6edcd9a9b", forHTTPHeaderField: "app_key")
//            do {
//                let encodedImage = encodeImage(image)
//                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["image":encodedImage, "gallery_name":"allFaces"], options: .PrettyPrinted)
//                let session = NSURLSession.sharedSession()
//                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
//                task.resume()
//            } catch {
//                print("Something went wrong! \(error)")
//            }
//        }
//    }
//    
    static func submitImageForEnrollment(image: UIImage, andId: String, completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void) {
        if let urlToReq = NSURL(string: "https://api.kairos.com/enroll") {
            let request = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//            request.setValue(app_key, forHTTPHeaderField: "X-Mashape-Key")
            do {
//                saveImageToFile(image)
                let documentsDirectoryURL = try! NSFileManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
//                print(documentsDirectoryURL)
                // create a name for your image
                let fileURL = documentsDirectoryURL.URLByAppendingPathComponent("face_image.png")
                print(fileURL)
                //automatically overwrites
                if UIImagePNGRepresentation(image)!.writeToFile(fileURL.path!, atomically: true) {
                    print("file saved")
                } else {
                    print("error saving file")
                }
                
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["urls":"https://upload.wikimedia.org/wikipedia/commons/1/18/Vombatus_ursinus_-Maria_Island_National_Park.jpg", "album":album, "albumkey":albumkey, "enryid":andId], options: .PrettyPrinted)
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request, completionHandler: completionHandler)
                task.resume()
            } catch {
                print("Something went wrong! \(error)")
            }
        }
    }
    
}
