//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Mamadou A. Balde on 4/8/19.
//  Copyright © 2019 MamadouABalde. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        //Schema of our table pet, with our arbitrary dictionaries
        post["caption"] =   commentField.text!
        post["author"] =   PFUser.current()!
      
        
        let imageData = imageView.image!.pngData() //save our image as png
        //let file = PFFileObject(data: imageDat)
        let file = PFFileObject(data: imageData!)
        post["image"] = file      // then save our schema
        post.saveInBackground { (success, error) in
            
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            }else{
                print("error!")
            }
        }
        
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
    
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage //info is a dictionary and image is casted to an UIImage
        
        // Resigning our image
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil) // dismiss the camera view
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
