//
//  ViewController.swift
//  IOSCustomerSurvey
//
//  Created by Cary Song on 2017/9/2.
//  Copyright © 2017年 Volvo. All rights reserved.
//

import UIKit
import Alamofire
import Charts

class ReportGenerationViewController: UIViewController {

   
    @IBOutlet weak var pieChart1: PieChartView!
    
    
    @IBOutlet weak var pieChar2: PieChartView!
    
    @IBOutlet weak var barChart: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateReports();
    }

    
    func generateReports(){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        
                let to = dateFormatter.string(from: Date())
        
                let secondsPerday:TimeInterval = 24*60*60
        
                let dateFrom = Date(timeIntervalSinceNow: secondsPerday * -10)
        
                let from = dateFormatter.string(from: dateFrom)
        
                let parameters: Parameters = ["DealerId": "633100","DealerName": "","DurationFrom": from, "durationTo":to ]
        
                let token = UserDefaults.standard.string(forKey: TOKEN)
        
                AFWrapper.PostWithToken(ReportStatistic_URL,params: parameters,token: token!,success: {(model) -> Void in
                    let serviceCheckIn = model.ServiceCheckIn
                    let serviceOnTime = model.ServiceDeliveryOnTim
                    let serviceOverall = model.ServiceOverall
                    self.pieChartCheckInUpdate(numbers: serviceCheckIn!)
                    self.pieChartOnTimeUpdate(numbers: serviceOnTime!)
                    self.serviceBarChartUpdate(numbers: serviceOverall!)
                    }) {
                        (error) -> Void in
                        print(error)
                    }
            }
            func serviceBarChartUpdate (numbers: [Int]) {
        
                let entry1 = BarChartDataEntry(x: 1.0, y: Double(numbers[0]))
                let entry2 = BarChartDataEntry(x: 2.0, y: Double(numbers[1]))
                let entry3 = BarChartDataEntry(x: 3.0, y: Double(numbers[2]))
                let entry4 = BarChartDataEntry(x: 4.0, y: Double(numbers[3]))
        
                let entry5 = BarChartDataEntry(x: 5.0, y: Double(numbers[4]))
        
        
                let dataSet = BarChartDataSet(values: [entry1, entry2, entry3,entry4, entry5], label: "ServiceOverall")
                dataSet.colors = ChartColorTemplates.pastel()
                let data = BarChartData(dataSets: [dataSet])
        
                barChart.data = data
                barChart.chartDescription?.text = "Serive Overall"
        
                barChart.xAxis.labelPosition = .bottom
                //All other additions to this function will go here
        
                //This must stay at end of function
                barChart.notifyDataSetChanged()
            }
        
            func pieChartCheckInUpdate (numbers: [Int]) {
                let entry1 = PieChartDataEntry(value: Double(numbers[0]), label: "#1")
                let entry2 = PieChartDataEntry(value: Double(numbers[1]), label: "#2")
                let entry3 = PieChartDataEntry(value: Double(numbers[2]), label: "#3")
                let entry4 = PieChartDataEntry(value: Double(numbers[3]), label: "#4")
                let entry5 = PieChartDataEntry(value: Double(numbers[4]), label: "#5")
                let dataSet = PieChartDataSet(values: [entry1, entry2, entry3,entry4,entry5], label: "Widget Types")
                dataSet.colors = ChartColorTemplates.joyful()
                let data = PieChartData(dataSet: dataSet)
        
        
                pieChart1.data = data
                pieChart1.chartDescription?.text = "Share of Widgets by Type"
        
                //All other additions to this function will go here
        
                //This must stay at end of function
                pieChart1.notifyDataSetChanged()
            }
        
            func pieChartOnTimeUpdate (numbers: [Int]) {
                let entry1 = PieChartDataEntry(value: Double(numbers[0]), label: "#1")
                let entry2 = PieChartDataEntry(value: Double(numbers[1]), label: "#2")
        
                let dataSet = PieChartDataSet(values: [entry1, entry2], label: "On Time")
                var colors = [UIColor]()
                colors.append(UIColor ( red: 0.8185, green: 0.8172, blue: 0.0023, alpha: 1.0 ))
                colors.append(UIColor ( red: 0.0, green: 0.81, blue: 0.81, alpha: 1.0 ))
                colors.append(UIColor.green)
                colors.append(UIColor.gray)
                colors.append(UIColor.purple)
                colors.append(UIColor.blue)
                dataSet.colors = colors
                
            
                let data = PieChartData(dataSet: dataSet)
                pieChar2.data = data
                pieChar2.chartDescription?.text = "Service Delivery on Time"
                
                //All other additions to this function will go here
                
                //This must stay at end of function
                pieChar2.notifyDataSetChanged()
            }



}

