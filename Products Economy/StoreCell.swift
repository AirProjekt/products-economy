//
//  StoreCell.swift
//  Products Economy
//
//  Created by Nobel on 7/6/17.
//  Copyright © 2017 Nobel. All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {
    
    
    @IBOutlet weak var storeLabel: UILabel!

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(store: Store) {
        storeLabel.text = store.name
        if let image = store.logoImg {
            let url = URL(string: image.imageMedium)!
            self.logoImageView.af_setImage(withURL: url)
        }
        else{
            self.logoImageView.image = UIImage(named: "placeholder")
        }
    }

}
