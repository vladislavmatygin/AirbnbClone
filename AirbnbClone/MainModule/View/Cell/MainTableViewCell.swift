//
//  MainTableViewCell.swift
//  AirbnbClone
//
//  Created by Владислав Матыгин on 14.12.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet private var view: UIView!
    @IBOutlet private var homeImageView: UIImageView!
    @IBOutlet private var placeLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var numberLabel: UILabel!
    @IBOutlet private var nightLabel: UILabel!
    @IBOutlet private var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    private func setup() {
        homeImageView.layer.cornerRadius = 35
        homeImageView.layer.masksToBounds = true
        homeImageView.image = UIImage(named: "home")
    }
    
    func config(floor: Floor) {
        homeImageView.image = UIImage(named: floor.imageName)
        placeLabel.text = floor.place
        nameLabel.text = floor.minimalizedName
        numberLabel.text = floor.cost
        likeButton.imageView?.image = UIImage(named: "like")
        likeButton.tintColor = floor.isLiked ? UIColor.red : UIColor.black
    }
}
