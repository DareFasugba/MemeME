//
//  MemeMeCollectionViewCell.swift
//  MemeMe
//
//  Created by The Fasugba Crew  on 3/12/2022.
//

import UIKit


class MemeMeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var MemeImageView: UIImageView!
        func setLabel(label:String) {
        nameLabel.text = label
    }
}
