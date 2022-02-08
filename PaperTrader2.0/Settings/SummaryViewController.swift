//
//  SummaryViewController.swift
//  PaperTrader2.0
//
//  Created by Jimmy  on 2/5/22.
//

import UIKit
import CoreData
import Charts

class SummaryViewController: UITableViewController,ChartViewDelegate  {
    var pieChart = PieChartView()
    @IBOutlet var changeAmountLabel: UILabel!
    @IBOutlet var totalProfitMade: UILabel!
    
    
    //store avg cost of each stock in database and set the label to the one with the highest gain
    @IBOutlet var biggestWin: UILabel!
    @IBOutlet var biggestLoss: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        pieChart.delegate = self
        pieChart.frame = CGRect(x:0,y:0, width: self.view.frame.size.width, height:300)

        view.addSubview(pieChart)
        var entriesPie = [ChartDataEntry]()
        for x in 0..<10 {
            entriesPie.append(ChartDataEntry(x:Double(x),y:Double(x)))
        }
        let setPie = PieChartDataSet(entries:entriesPie)
        setPie.colors = ChartColorTemplates.material()
        let dataPie = PieChartData(dataSet:setPie)
        pieChart.data = dataPie
        
        changeAmountLabel.text = String(defaults.double(forKey: "changeAmount"))
        
    }
    
}
