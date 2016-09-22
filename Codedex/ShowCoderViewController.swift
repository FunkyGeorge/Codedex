//
//  ShowCoderViewController.swift
//  Codedex
//
//  Created by Annie Ritch on 9/22/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import UIKit

//class ShowCoderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
class ShowCoderViewController: UIViewController {
    
    
    var name: String?
    var status: String?
    var level: String?
    var specialty: String?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ninjaLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    var pickedImage: UIImage! //get this from segue
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    @IBAction func homeButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set image view
        imageView.contentMode = .ScaleAspectFit
        imageView.autoresizesSubviews = true
        imageView.image = pickedImage!
        
        nameLabel.text = name
        statusLabel.text = status
        ninjaLabel.text = level
        specialtyLabel.text = specialty
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
