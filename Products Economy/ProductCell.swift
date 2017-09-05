//
//  ProductCell.swift
//  Products Economy
//
//  Created by Nobel on 7/9/17.
//  Copyright © 2017 Nobel. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductCell: UICollectionViewCell {
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ product: Product) {
        
        self.nameLabel.text = product.name
        if let image = product.image {
            let url = URL(string: image.imageLarge)!
            self.productImage.af_setImage(withURL: url)
        }
        else{
            self.productImage.image = UIImage(named: "placeholder")
        }
        
    }
    
}
