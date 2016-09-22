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
            CodedexModel.submitImageForEnrollment(pickedImage, andId: "George") {
                data, response, error in
                do {
                    print("hey")
                    
                    if let results = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        print(results)
                    }
                    
                } catch {
                    print("Error: \(error)")
                }
               
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }



}

