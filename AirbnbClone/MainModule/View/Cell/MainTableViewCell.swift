//
//  MainTableViewCell.swift
//  AirbnbClone
//
//  Created by Владислав Матыгин on 14.12.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet var view: UIView!
    @IBOutlet var homeImageView: UIImageView!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var nightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        homeImageView.image = UIImage(named: "home")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
