//
//  imagePickerDelegate.swift
//  MemeMe
//
//  Created by The Fasugba Crew  on 15/10/2022.
//

import Foundation
import UIKit

class ImagePickerDelegate : NSObject & UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.editedImage] as? UIImage else { return }
      weak var ImagePickerView: UIImageView!
      weak var LeftBarButton: UIBarButtonItem!
      weak var ShareButton: UIBarButtonItem!
      ImagePickerView.image = image
            picker.dismiss(animated: true, completion: nil)
            LeftBarButton?.isEnabled = true
      ShareButton.isEnabled = true
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
  }
