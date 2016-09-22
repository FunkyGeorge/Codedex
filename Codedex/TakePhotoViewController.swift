//
//  ViewController.swift
//  Codedex
//
//  Created by Annie Ritch on 9/21/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import UIKit

class TakePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func takePhotoButtonPressed(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.autoresizesSubviews = true
            imageView.image = pickedImage
//            CodedexModel.submitImageForEnrollment(pickedImage, andId: "Annie") {
            CodedexModel.submitImageForRecognition(pickedImage) {
                data, response, error in
                do {
                    print("hey")
                    
                    if let results = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        if let imageArray = results["images"] as? NSArray {

                            if let transaction = imageArray[0]["transaction"] as? NSDictionary {
                                if let status = transaction["status"] as? String {
                                    if status == "success" {
                                        //found the photo! proceed with subject name
                                        if let subject = transaction["subject"] as? String {
                                            print(subject)
                                            //GET SUBJECT AND PERFORM SEGUE TO VIEW SUBJECT
                                            
                                        }
                                    } else {
                                        //no matches found
                                        if let message = transaction["message"] as? String {
                                            print(message)
                                            if message == "No match found" {
                                                print("no matches")
                                                //ask get user to add photo to gallery
                                                self.addEnrollImageAlert()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        //couldn't find a face: returns a separate error object
                        if let errorArray = results["Errors"] as? NSArray {
                            if let error = errorArray[0] as? NSDictionary {
                                if let message = error["Message"] as? String {
                                    if message == "no faces found in the image" {
                                        print("no faces")
                                        //inform user that no faces were found
                                        self.addNoFacesAlert()
                                    }
                                }
                            }
                        }
                    }
                    
                } catch {
                    print("Error: \(error)")
                }
               
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    /**** ALERTS ****/
    
    //alert to enroll new image
    func addEnrollImageAlert() {
        let alert = UIAlertController(title: "No Matches Found", message: "Add a new coder to Codedex", preferredStyle: .Alert)
        
        //user clicks Add Face
        let addFaceAction = UIAlertAction(title: "Add Coder", style: .Default) {
            (action: UIAlertAction!) -> Void in
            //ADD IMPLEMENTATION TO SEGUE TO AN ADD PAGE OR SOMETHING
            let pickedImage = self.imageView.image
            self.performSegueWithIdentifier("AddCoderSegue", sender: pickedImage)
        }
        
        //user clicks cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction) -> Void in //do nothing
        }
        
        //register buttons to alert box
        alert.addAction(addFaceAction)
        alert.addAction(cancelAction)
        
        //register alert box to view controller
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    //alert that no face was detected
    func addNoFacesAlert() {
        let alert = UIAlertController(title: "No Faces Detected", message: "Try taking another photo", preferredStyle: .Alert)
        
        //user clicks to try again
        let addTryAgainAction = UIAlertAction(title: "Okay", style: .Default) {
            (action: UIAlertAction!) -> Void in
            //ADD IMPLEMENTATION TO SOMETHING
        }
        
        
        //register button to alert box
        alert.addAction(addTryAgainAction)
        
        //register alert box to view controller
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(alert, animated: true, completion: nil)
        })
        
    }
    
    /***** SEGUE *****/

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddCoderSegue" {
            let addCoderViewController = segue.destinationViewController as! AddCoderViewController
            addCoderViewController.pickedImage = sender as! UIImage
        }
    }


}

