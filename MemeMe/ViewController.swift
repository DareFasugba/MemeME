//
//  ViewController.swift
//  MemeMe
//
//  Created by The Fasugba Crew  on 15/10/2022.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    let imagePickerDelegate = ImagePickerDelegate()
    let textFieldDelegate = TextFieldDelegate()

    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BottomTextField: UITextField!
    @IBOutlet weak var ImagePickerView: UIImageView!
    @IBOutlet weak var NavigationItem: UIToolbar!
    @IBOutlet weak var LeftBarButton: UIBarButtonItem!
    let textAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth:  -5.0
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            TopTextField.delegate = self
            BottomTextField.delegate = self
            TopTextField.defaultTextAttributes = textAttributes
            BottomTextField.defaultTextAttributes = textAttributes
            TopTextField.textAlignment = .center
            BottomTextField.textAlignment = .center
        }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
   
    @IBAction func pickAnImageFromCamera(_ sender: Any) {

            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            ImagePickerView.image = image
            picker.dismiss(animated: true)
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func subscribeToKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        func unsubscribeToKeyboardNotifications() {
            NotificationCenter.default.removeObserver(self)
        }
    @objc func keyboardWillShow(_ notification:Notification) {
            if BottomTextField.isFirstResponder {
                view.frame.origin.y -= getKeyboardHeight(notification)
            }
        }
        @objc func keyboardWillHide(_ notification:Notification) {
            view.frame.origin.y = 0
        }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
   
    var origImage: UIImageView!
    var meme: Meme!
    struct Meme {
    var topTextField: String = ""
    var bottomTextField: String = ""
    var originalImage: UIImage!
    var memedImage: UIImage!
    } /* struct Meme s*/
    //--------------------------
    func generateMemedImage() -> UIImage {
    //--------------------------
    // TODO: Hide toolbar and navbar
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
    let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    // TODO: Show toolbar and navbar
    return memedImage
    } /* generateMemedImage */
    //--------------------------
    func save() {
    //--------------------------
    // Create the meme
    meme = Meme(topTextField: TopTextField.text!,
    bottomTextField: BottomTextField.text!,
    originalImage: ImagePickerView.image!,
    memedImage: generateMemedImage())
    } /* save */
    }
    
        


