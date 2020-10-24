//
//  AppDelegate.swift
//  app5-Sara-Reddy
//
//  Created by Sara on 10/20/20.
//  Copyright © 2020 Sara. All rights reserved.
//

import Foundation

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var contact: Contact?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        print("tapped")
        presentImagePicker()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        company.text = contact?.company
        email.text = contact?.email
        phoneNumber.text = contact?.phoneNumber
        name.text = (contact?.firstName ?? "") + " " + (contact?.lastName ?? "")
        //picture
    }
    
    func imagePickerController(_ : UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            picture.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }


}
