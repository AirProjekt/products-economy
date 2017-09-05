//
//  StoreTableVC.swift
//  Products Economy
//
//  Created by Nobel on 7/6/17.
//  Copyright © 2017 Nobel. All rights reserved.
//

import UIKit
import Alamofire

class StoreTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var stores = [Store]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        parseStoreData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as? StoreCell {
            
            let store = stores[indexPath.row]
            cell.configureCell(store: store)
            return cell
        } else {
            return StoreCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataService.activeStore = stores[indexPath.row]
        self.performSegue(withIdentifier: "productCollectionVC", sender: nil)
    }
    
    func parseStoreData(){
        let parameters: Parameters = ["expand": "logo0"]
        DataService.sharedManager.request("\(BASE_URL)\(STORE_URL)",parameters: parameters).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String,AnyObject>{
                if let storeList = dict["collection"] as? [Dictionary<String,AnyObject>] {
                    for element in storeList {
                        let store = Store(storeDict: element)
                        self.stores.append(store)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    

}
