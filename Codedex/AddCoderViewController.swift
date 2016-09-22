//
//  AddCoderViewController.swift
//  Codedex
//
//  Created by Annie Ritch on 9/22/16.
//  Copyright © 2016 Andrea Ritch. All rights reserved.
//

import UIKit

class AddCoderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var pickedImage: UIImage! //get this from segue

    override func viewDidLoad() {
        super.viewDidLoad()

        //set image view
        imageView.contentMode = .ScaleAspectFit
        imageView.autoresizesSubviews = true
        imageView.image = pickedImage!
        
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
