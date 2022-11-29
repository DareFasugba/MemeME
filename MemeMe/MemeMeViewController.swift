//
//  MemeMeCollectionViewController.swift
//  MemeMe
//
//  Created by The Fasugba Crew  on 24/11/2022.
//

import Foundation
import UIKit
class MemeMeViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
            let width = (view.frame.size.width - (2 * space)) / 3.0
            let height = (view.frame.size.height - (2 * space)) / 3.0
            flowLayout.minimumLineSpacing = space
            flowLayout.minimumInteritemSpacing = space
            flowLayout.itemSize = CGSize(width: width, height: height)
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tabBarController?.tabBar.isHidden = false
            collectionView.reloadData()
        }
        // MARK: Set collection data source
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return memes.count
        }
        // MARK: Set cell view
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeMeCollectionViewCell", for: indexPath) as! MemeMeCollectionViewCell
            let meme = getMeme(indexPath: indexPath)
            cell.nameLabel.text = meme.topTextField + "..." + meme.bottomTextField
            cell.MemeImageView.image = meme.memedImage
            return cell
        }
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let detailViewController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
            detailViewController.meme = getMeme(indexPath: indexPath)
            navigationController!.pushViewController(detailViewController, animated: true)
        }
        func getMeme(indexPath: IndexPath) -> Meme {
            return memes[(indexPath as NSIndexPath).row]
        }
    @IBAction func ButtonToViewController(){
        performSegue(withIdentifier: "ViewControllerSegue", sender: self)
    }
    }

       
