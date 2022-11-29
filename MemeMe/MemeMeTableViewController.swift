//
//  MemeMeTableViewController.swift
//  MemeMe
//
//  Created by The Fasugba Crew  on 27/11/2022.
//

import Foundation
import UIKit
class MemeMeTableViewController: UITableViewController {
    // MARK: Properties
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    // MARK: View states
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeMeTableViewCell")!
        let meme = getMeme(indexPath: indexPath)
        cell.textLabel?.text = meme.topTextField + "..." + meme.bottomTextField
        cell.imageView?.image = meme.memedImage
        // Populate detail text label if using subtitle mode.
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = "Top: \(meme.topTextField) | Bottom: \(meme.bottomTextField)"
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
