//
//  AddCoderViewController.swift
//  Codedex
//
//  Created by Annie Ritch on 9/22/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import UIKit

class AddCoderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var levelTextField: UITextField!
    @IBOutlet weak var specialtyTextField: UITextField!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var pickedImage: UIImage! //get this from segue
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    @IBAction func homeButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(pickedImage)
//        scrollView = UIScrollView(frame: view.bounds)
//        scrollView.contentSize = view.bounds.size
        
//        nameTextField.delegate = self
//        statusTextField.delegate = self
//        levelTextField.delegate = self
//        specialtyTextField.delegate = self

        //set image view
        imageView.contentMode = .ScaleAspectFit
        imageView.autoresizesSubviews = true
        imageView.image = pickedImage!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCoderButtonPressed(sender: UIButton) {
        //add to database!!
        let name = nameTextField.text!
        let status = statusTextField.text!
        let level = levelTextField.text!
        let specialty = specialtyTextField.text!
        CoderModel.addUser(name, status: status, level: level, specialty: specialty) {
            data, response, error in
            do {
                if let results = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                    print(results)
                }
            } catch {
                print("Something went wrong")
            }
            self.performSegueWithIdentifier("ShowCoderSegue", sender: self.imageView.image)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowCoderSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let showCoderViewController = navigationController.topViewController as! ShowCoderViewController
            showCoderViewController.pickedImage = sender as! UIImage
            showCoderViewController.cancelButtonDelegate = cancelButtonDelegate
        }
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        print("yo")
        scrollView.setContentOffset(CGPointMake(0, 250), animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("hi")
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }

}
