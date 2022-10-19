//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by The Fasugba Crew  on 17/10/2022.
//

import Foundation
import UIKit

class TextFieldDelegate: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var BottomTextField: UITextField!
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var ImagePickerView: UIImageView!
    let textAttributes: [NSAttributedString.Key: Any] = [
    NSAttributedString.Key.strokeColor: UIColor.black,
    NSAttributedString.Key.foregroundColor: UIColor.white,
    NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSAttributedString.Key.strokeWidth:  5.0
                         ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        func setupTextField(textField: UITextField, text: String) {
            TopTextField.delegate = self
            BottomTextField.delegate = self
            TopTextField.defaultTextAttributes = textAttributes
        BottomTextField.defaultTextAttributes = textAttributes
            
        textField.textAlignment = .center
        
        TopTextField.text = "TOP"
        BottomTextField.text = "BOTTOM"
        }
        
    }
    
    
}
