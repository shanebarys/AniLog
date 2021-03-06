//
//  ViewController.swift
//  AniLog
//
//  Copyright © 2020 Shane Barys. All rights reserved.
//

import UIKit

class AnimalListViewController: UIViewController, AnimalTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var animals: Animals!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        animals = Animals()
//        animals.animalArray.append(Animal(type: "Dog", name: "Jockey", description: "hyperactive", rating: "13", picture: SomeImage(photo: UIImage()), dateMet: "10/21/16"))
//        animals.animalArray.append(Animal(type: "Dog", name: "Cossa", description: "sluggish, cuddly", rating: "12", picture: SomeImage(photo: UIImage()), dateMet: "09/37/18"))
//        animals.animalArray.append(Animal(type: "Slug", name: "Wallace", description: "slimy, rude", rating: "3", picture: SomeImage(photo: UIImage()), dateMet: "04/21/20"))
        // Do any additional setup after loading the view.
        loadData()
    }

    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("animals").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {return}
        
        let jsonDecoder = JSONDecoder()
        do {
            animals = try jsonDecoder.decode(Animals.self, from: data)
            tableView.reloadData()
        } catch {
            print("💔 ERROR: Could not load data, \(error.localizedDescription)")

        }
        
    }
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("animals").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(animals)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("💔 ERROR: Could not save data, \(error.localizedDescription)")
        }
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
        saveData()
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            animals.animalArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let animalToMove = animals.animalArray[sourceIndexPath.row]
        animals.animalArray.remove(at: sourceIndexPath.row)
        animals.animalArray.insert(animalToMove, at: destinationIndexPath.row)
        saveData()
    }
    
}

