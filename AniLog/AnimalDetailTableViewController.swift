//
//  AnimalDetailTableViewController.swift
//  AniLog
//
//  Created by Shane Barys on 4/26/20.
//  Copyright © 2020 Shane Barys. All rights reserved.
//

import UIKit

class AnimalDetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var picture: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        picture.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}
