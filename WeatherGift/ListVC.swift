//
//  ListVC.swift
//  WeatherGift
//
//  Created by Michael Green on 3/14/18.
//  Copyright © 2018 mgreen. All rights reserved.
//

import UIKit

class ListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    var locationsArray = [String]()
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPageVC" {
            let destination = segue.destination as! PageVC
            currentPage = (tableView.indexPathForSelectedRow?.row)!
            destination.locationsArray = locationsArray
            destination.currentPage = currentPage
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locationsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = locationsArray[sourceIndexPath.row]
        locationsArray.remove(at: sourceIndexPath.row)
        locationsArray.insert(itemToMove, at: destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return (indexPath.row != 0 ? true : false)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return (indexPath.row != 0 ? true : false)
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return (proposedDestinationIndexPath.row == 0 ? sourceIndexPath : proposedDestinationIndexPath) 
    }
    
    @IBAction func editBarButtonPressed(_ sender: Any) {
        if tableView.isEditing == true {
            tableView.setEditing(false, animated: true)
            addBarButton.isEnabled = true
            editBarButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled=false
            editBarButton.title = "Done"
        }
    }
    

}

extension ListVC: UITableViewDataSource, UITableViewDelegate {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locationsArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
    cell.textLabel?.text = locationsArray[indexPath.row]
    return cell
}
}
