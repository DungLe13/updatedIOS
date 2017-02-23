//
//  writeReviewViewController.swift
//  MapLocator
//
//  Created by Student on 5/15/16.
//  Copyright © 2016 Dung Le. All rights reserved.
//

import UIKit
import Firebase

class writeReviewViewController: UIViewController {
    
    @IBOutlet weak var nameOfPlace: UITextField!
    
    @IBOutlet weak var categoryText: UITextField!
    
    @IBOutlet weak var starRating: CosmosView!
    
    @IBOutlet weak var reviewText: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleReview: UITextField!
    
    let ref = Firebase(url: "https://map-locator.firebaseio.com/reviews")
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: AnyObject) {
        let name = nameOfPlace.text
        let category = categoryText.text
        let title = titleReview.text
        let review = reviewText.text
        
        var data: Data = Data()
        
        if let image = photoImageView.image {
            data = UIImageJPEGRepresentation(image, 0.1)!
        }
        
        let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
        
        let place: NSDictionary = ["name": name!, "categories": category!, "rating": starRating.rating, "photoBase64": base64String, "titleReview": title!, "userReviews": review!]
        
        let placeReview = self.ref.childByAppendingPath(name!)
        
        placeReview.setValue(place)
        
        navigationController?.dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

}

extension writeReviewViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK:- UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Add Picture
    
    @IBAction func takePicture(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func uploadPicture(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
}



