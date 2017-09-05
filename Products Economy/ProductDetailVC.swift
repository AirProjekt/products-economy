//
//  ProductDetailVC.swift
//  Products Economy
//
//  Created by Nobel on 7/10/17.
//  Copyright © 2017 Nobel. All rights reserved.
//

import UIKit
import Charts

class ProductDetailVC: UIViewController {
    
    var product: Product!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var sellingPriceLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = product.name
        if let image = product.image {
            let url = URL(string: image.imageOriginal)!
            productImage.af_setImage(withURL: url)
        }
        else{
            productImage.image = UIImage(named: "placeholder")
        }
        sellingPriceLabel.text = "\(product.sellingPrice) kr"
        stockPriceLabel.text = "\(product.stockPrice) kr"
        categoryLabel.text = product.categoryName
        taxLabel.text = "\(product.taxRate) %"
        buildBarChart()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func buildBarChart(){
        DataService.sharedManager.request("\(BASE_URL)\(PRODUCT_URL)/\(product.uid)/analytics").validate().responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String,AnyObject> {
                if let graphList = dict["graph"] as? [Dictionary<String,AnyObject>] {
                    var dataEntries : [BarChartDataEntry] = []
                    for graph in graphList {
                        if let month = graph["sales_date"] as? String, let total = graph["total"] as? String {
                            let dataEntry = BarChartDataEntry(x: Double(month)!, y: Double(total)!)
                            dataEntries.append(dataEntry)
                        }
                    }
                    let chartDataSet = BarChartDataSet(values: dataEntries, label: "Total Amount (kr)")
                    let chartData = BarChartData(dataSet: chartDataSet)
                    self.barChartView.data = chartData
                }
            }
            
        }
    }


}
