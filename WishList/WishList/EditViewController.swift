//
//  EditViewController.swift
//  WishList
//
//  Created by 김태균 on 2021/05/26.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    @IBAction func tapAddImageButton() {
        didTapPhotoImage()
    }
    
    private let wishData = DataBaseHelper.shareInstance
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        priceField.delegate = self
        self.title = "Edit Item"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(editTask))
        let tapGestuerRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPhotoImage))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGestuerRecognizer)
        photoImageView.layer.cornerRadius = 12
        
        nameField.keyboardType = .default
        priceField.keyboardType = .numberPad
    }
    
    // MARK: - Helpers
    
    
    // MARK: - Actions
    
    @objc func didTapPhotoImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func editTask() {
        guard let name = nameField.text else { return }
        guard let price = Int64(priceField.text!) else { return }
        wishData.updateItem(item: wishData.models.first!, newName: name, newImage: (photoImageView.image?.pngData())!, newPrice: price)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
 
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        photoImageView.image = selectedImage
        photoImageView.layer.masksToBounds = true
        photoImageView.contentMode = .scaleAspectFill

        self.dismiss(animated: true, completion: nil)
    }
}
