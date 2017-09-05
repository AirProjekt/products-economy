//
//  ProductCollectionVC.swift
//  Products Economy
//
//  Created by Nobel on 7/7/17.
//  Copyright © 2017 Nobel. All rights reserved.
//

import UIKit
import Alamofire

class ProductCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    

    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var activeStoreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var products = [Product]()
    var filteredProducts = [Product]()
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let activeStore = DataService.activeStore
        activeStoreLabel.text = activeStore.name
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parseProductData()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func singOutBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "unwingSegueToSingIn", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCell {
            
            let product: Product!
                
            product = getProduct(index: indexPath.row)
            cell.configureCell(product)
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filteredProducts.count
        }
        return products.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedProduct:Product!
        selectedProduct = getProduct(index: indexPath.row)
        self.performSegue(withIdentifier: "productDetailVC", sender: selectedProduct)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
        } else {
            isSearching = true
            let searchText = searchBar.text!.lowercased()
            filteredProducts = products.filter({$0.name.range(of: searchText) != nil})
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func start()
    {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stop()
    {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func parseProductData(){
        start()
        let parameters: Parameters = ["client": DataService.activeStore.uid]
        DataService.sharedManager.request("\(BASE_URL)\(PRODUCT_URL)",parameters: parameters).validate().responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String,AnyObject>{
                if let productList = dict["products"] as? [Dictionary<String,AnyObject>] {
                    for element in productList {
                        let product = Product(productDict: element)
                        self.products.append(product)
                    }
                    self.collectionView.reloadData()
                }
            }
            self.stop()

        }
    }
    
    func getProduct(index: Int) -> Product {
        if isSearching {
            return filteredProducts[index]
        }
        else {
            return products[index]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetailVC" {
            if let productDetailVC = segue.destination as? ProductDetailVC {
                if let product = sender as? Product {
                    productDetailVC.product = product
                }
            }
        }
    }

}
