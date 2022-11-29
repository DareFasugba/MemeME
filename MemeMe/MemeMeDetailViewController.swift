//
//  MemeMeDetailViewController.swift
//  MemeMe
//
//  Created by The Fasugba Crew  on 29/11/2022.
//

import Foundation
import UIKit
class MemeDetailViewController: UIViewController {
    var meme: Meme?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView?.image = meme?.memedImage
    }
    @IBOutlet weak var imageView: UIImageView!
}
