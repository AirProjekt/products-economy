//
//  Image.swift
//  Products Economy
//
//  Created by Nobel on 7/10/17.
//  Copyright © 2017 Nobel. All rights reserved.
//

import Foundation

class Image {
    
    private var _imageOriginal: String!
    private var _imageLarge: String!
    private var _imageMedium: String!
    private var _imageSmall: String!
    
    init(imageDict: Dictionary<String, AnyObject>) {
        if let imageOriginal = imageDict["image_original"] as? String {
            self._imageOriginal = imageOriginal
        }
        if let imageSmall = imageDict["image_small"] as? String {
            self._imageSmall = imageSmall
        }
        if let imageMedium = imageDict["image_medium"] as? String {
            self._imageMedium = imageMedium
        }
        if let imageLarge = imageDict["image_large"] as? String {
            self._imageLarge = imageLarge
        }
    }
    
    var imageOriginal:String {
        if _imageOriginal == nil {
            return "local_url"
        }
        return _imageOriginal
    }
    
    var imageSmall:String {
        if _imageSmall == nil {
            return "local_url"
        }
        return _imageSmall
    }
    
    var imageMedium:String {
        if _imageMedium == nil {
            return "local_url"
        }
        return _imageMedium
    }
    
    var imageLarge:String {
        if _imageLarge == nil {
            return "local_url"
        }
        return _imageLarge
    }
    
}
