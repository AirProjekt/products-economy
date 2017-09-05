//
//  Product.swift
//  Products Economy
//
//  Created by Nobel on 7/10/17.
//  Copyright © 2017 Nobel. All rights reserved.
//

import Foundation

class Product{
    
    private var _uid:Int!
    private var _name:String!
    private var _stockPrice:Int!
    private var _sellingPrice:Int!
    private var _categoryName:String!
    private var _taxRate:Int!
    private var _image:Image!
    
    init(productDict: Dictionary<String, AnyObject>) {
        if let id = productDict["uid"] as? Int {
            self._uid = id
        }
        if let name = productDict["name"] as? String {
            self._name = name
        }
        if let stockPrice = productDict["stock_price"] as? Int {
            self._stockPrice = stockPrice
        }
        if let sellingPrice = productDict["selling_price"] as? Int {
            self._sellingPrice = sellingPrice
        }
        if let tagDict = productDict["tag0"] as? Dictionary<String, AnyObject> {
            if let categoryName = tagDict["name"] as? String {
                self._categoryName = categoryName
            }
        }
        if let taxDict = productDict["tax0"] as? Dictionary<String, AnyObject> {
            if let taxRate = taxDict["percentage"] as? Int {
                self._taxRate = taxRate
            }
        }
        if let imageDict = productDict["image"] as? Dictionary<String, AnyObject> {
            let newImage = Image(imageDict: imageDict)
            self._image = newImage
        }
        
    }
    
    var uid:Int{
        return _uid
    }
    
    var name:String{
        if _name == nil {
            return ""
        }
        return _name
    }
    
    var stockPrice:Int{
        if _stockPrice == nil {
            return 0
        }
        return _stockPrice
    }
    
    var sellingPrice:Int{
        if _sellingPrice == nil {
            return 0
        }
        return _sellingPrice
    }
    
    var categoryName:String {
        if _categoryName == nil {
            return "No Category"
        }
        return _categoryName
    }
    
    var taxRate:Int{
        if _taxRate == nil {
            return 25
        }
        return _taxRate
    }
    
    var image:Image? {
        return _image
    }
    
    
}
