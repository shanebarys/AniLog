//
//  AnimalTableViewCell.swift
//  AniLog
//
//  Created by Shane Barys on 4/26/20.
//  Copyright © 2020 Shane Barys. All rights reserved.
//

import UIKit


protocol AnimalTableViewCellDelegate: class {

}

class AnimalTableViewCell: UITableViewCell {

    @IBOutlet weak var animalTypeLabel: UILabel!
    @IBOutlet weak var dateMetLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: AnimalTableViewCellDelegate?
    
var animal: Animal! {
        didSet {
            animalTypeLabel.text = animal.type
            nameLabel.text = animal.name
            dateMetLabel.text = animal.dateMet
            ratingLabel.text = String(animal.rating)
            animalImageView.image = animal.picture
            
            
        }
    }
}
