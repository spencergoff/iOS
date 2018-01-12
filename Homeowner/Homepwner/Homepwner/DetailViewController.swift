//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Spencer Goff on 7/2/17.
//  Copyright © 2017 Spencer Goff. All rights reserved.
//
//  Controlls the view so the user can edit an item's attributes

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameField: changeTextfieldBorderWhenFirstResponder!
    @IBOutlet var serialNumberField: changeTextfieldBorderWhenFirstResponder!
    @IBOutlet var valueField: changeTextfieldBorderWhenFirstResponder!
    @IBOutlet var dateLabel: UILabel!
  
    var item: Item! {
        /*this is a property observer that updates the title in the navigation bar*/
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        //if device has a camera, take a picture; else, choose from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        //adds image picker to the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func removePicture(_ sender: UIBarButtonItem) {
        imageStore.deleteImage(forKey: item.itemKey)
        imageView.image = nil
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //Store image in Imagestore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        //Place that image on screen in the image view
        imageView.image = image
        
        //take image picker off screen
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true) //dismisses keyboard
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true) //dismisses more keboard smoothly
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
        /*Note: after updating the model here, need to update the view via ItemsViewController, viewWillAppear()*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text =  item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars)) //makes value localizable 
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        let key = item.itemKey
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay 
    }
    
    private func textFieldShouldReturn(_ textField: changeTextfieldBorderWhenFirstResponder) -> Bool { //called when 'return' is pressed
        textField.resignFirstResponder() //dismisses keyboard
        return true
    }
    
}

class changeTextfieldBorderWhenFirstResponder: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        let becomeFirstResponder = super.becomeFirstResponder()
        if becomeFirstResponder {
            self.borderStyle = .bezel
        }
        return becomeFirstResponder
    }
    
    override func resignFirstResponder() -> Bool {
        let resignFirstResponder = super.resignFirstResponder()
        if resignFirstResponder {
            self.borderStyle = .roundedRect
        }
        return resignFirstResponder
    }
}
