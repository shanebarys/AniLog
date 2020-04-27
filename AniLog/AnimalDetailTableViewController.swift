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
    @IBOutlet weak var ratingField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var animal: Animal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if animal == nil {
            animal = Animal(type: "", name: "", description: "", rating: "", picture: UIImage(), dateMet: "")
        }
        
        typeField.text = animal.type
        nameField.text = animal.name
        dateField.text = animal.dateMet
        descriptionView.text = animal.description
        picture.image = animal.picture
        ratingField.text = animal.rating
       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        animal.type = typeField.text!
        animal.name = nameField.text!
        animal.dateMet = dateField.text!
        animal.picture = picture.image!
        animal.rating = ratingField.text!
        animal.description = descriptionView.text
        
        
        
        
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
