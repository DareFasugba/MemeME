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

    @IBOutlet weak var CameraButton: UIBarButtonItem!
    @IBOutlet weak var NavigationBar: UINavigationBar!
    @IBOutlet weak var ShareButton: UIBarButtonItem!
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
            prepareTextField(textField: BottomTextField,defaultText: "BOTTOM")
            prepareTextField(textField: TopTextField,defaultText: "TOP")
            ShareButton.isEnabled = false
            CameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
#if targetEnvironment(simulator)
CameraButton.isEnabled = false
#else
CameraButton.isEnabled = true
#endif
            
        }
    func prepareTextField(textField: UITextField, defaultText: String) {
        textField.delegate = self
        textField.defaultTextAttributes = textAttributes
        textField.textAlignment = .center
        textField.text = defaultText
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           subscribeToKeyboardNotifications()
       }
      
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           unsubscribeToKeyboardNotifications()
       }
    
    @IBAction func pickAnImage(_ sender: Any) {
            pick(sourceType: .photoLibrary)
        }
       
        @IBAction func pickAnImageFromCamera(_ sender: Any) {
            pick(sourceType: .camera)
            }
        
        func pick(sourceType: UIImagePickerController.SourceType ){
            let ImagePicker = UIImagePickerController()
            ImagePicker.delegate = self
            ImagePicker.sourceType = sourceType
            present(ImagePicker, animated: true, completion: nil)
        }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            ImagePickerView.image = image
            picker.dismiss(animated: true)
        ShareButton.isEnabled = true
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
    
    @IBAction func shareImage(_ sender: Any) {
        let sharedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [sharedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed && error == nil {
                self.save()
            }
        }
        present(controller,animated: true, completion: nil)
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
        NavigationBar.isHidden = true
        NavigationItem.isHidden = true
    // Render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
    let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
        NavigationBar.isHidden = false
        NavigationItem.isHidden = false
        dismiss(animated: true, completion: nil)
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
    
        


