//
//  Store.swift
//  Products Economy
//
//  Created by Nobel on 7/6/17.
//  Copyright © 2017 Nobel. All rights reserved.
//

import Foundation

class Store{
    
    private var _uid:Int!
    private var _name:String!
    private var _logoImg:Image!
    
    var uid:Int{
        return _uid
    }
    
    var name:String{
        if _name == nil {
            return ""
        }
        return _name
    }
    
    var logoImg:Image?{
        return _logoImg
    }
    
    init(storeDict: Dictionary<String, AnyObject>) {
        if let id = storeDict["uid"] as? Int {
            self._uid = id
        }
        
        if let storeName = storeDict["name"] as? String {
            self._name = storeName
        }
        if let logoDict = storeDict["logo0"] as? Dictionary<String, AnyObject> {
            let logoImg = Image(imageDict: logoDict)
            self._logoImg = logoImg
        }
    }
    
}
