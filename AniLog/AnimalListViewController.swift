//
//  ViewController.swift
//  AniLog
//
//  Created by Shane Barys on 4/26/20.
//  Copyright © 2020 Shane Barys. All rights reserved.
//

import UIKit

class AnimalListViewController: UIViewController, AnimalTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var animals: Animals!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        animals = Animals()
        animals.animalArray.append(Animal(type: "Dog", name: "Jockey", description: "hyperactive", rating: "13", picture: UIImage(), dateMet: "10/21/16"))
        animals.animalArray.append(Animal(type: "Dog", name: "Cossa", description: "sluggish, cuddly", rating: "12", picture: UIImage(), dateMet: "09/37/18"))
        animals.animalArray.append(Animal(type: "Slug", name: "Wallace", description: "slimy, rude", rating: "3", picture: UIImage(), dateMet: "04/21/20"))
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! AnimalDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.animal = animals.animalArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }

    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! AnimalDetailTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            animals.animalArray[selectedIndexPath.row] = source.animal
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: animals.animalArray.count, section: 0)
            animals.animalArray.append(source.animal)
            tableView.insertRows(at: [newIndexPath], with: .top)
            tableView.scrollToRow(at: newIndexPath, at: .top, animated: true)
        }
    }
}

extension AnimalListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.animalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnimalTableViewCell
        cell.delegate = self
        cell.animal = animals.animalArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    
}
