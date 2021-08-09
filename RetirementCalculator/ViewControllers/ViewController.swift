//
//  ViewController.swift
//  RetirementCalculator
//
//  Created by Ved Joshi on 6/14/21.
//

import UIKit



import Charts
import TinyConstraints

class ViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    
    @IBOutlet weak var monthlyExpenses: UITextField!
    @IBOutlet weak var yearsInRetirement: UITextField!
    @IBOutlet weak var preTaxRateField: UITextField!
    
    let INFLATIONRATE = 0.024;
    
   // let INFLATIONRATE = 0.02; ONLY FOR TESTING THIS IS NOWHERE NEAR ACCURATE
    
    
    
    
    lazy var lineChartView: LineChartView = {
        let chartVieww = LineChartView();
        //do line chart modifications here, like color and basic stuff
        chartVieww.backgroundColor = .systemPink
        chartVieww.rightAxis.enabled = false;
        chartVieww.xAxis.labelPosition = .bottom;
        
        chartVieww.animate(xAxisDuration: 1);
        
        return chartVieww;
        
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }
    
    
    
    func makeLineGraph(){
        chartView.addSubview(lineChartView)
        
        
        lineChartView.centerInSuperview()
        
        lineChartView.width(to: chartView);
        lineChartView.height(to: chartView);
        setData()
        
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData(){
        
        let set1 = LineChartDataSet(entries: yValues, label: "Dollar")
        let data = LineChartData(dataSet: set1);
        lineChartView.data = data;
        
        
        
        
    }
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x:1.0, y:5.0),
        
            ChartDataEntry(x:2.0, y:4.0),
        
            ChartDataEntry(x:3.0, y:5.6),
        
            ChartDataEntry(x:4.0, y:12.0)
        
        
    ]
    
    
    func generateTable(){
        let rate = 0.048
        let years = 45
        let monthly = 6000;
        let yearly = monthly*12;
        var retirementPay = [Int]()
        var i = 1;
        retirementPay.append(yearly);
        while(i <= years){
            let payDouble = ( Double(retirementPay[retirementPay.count - 1])  * (INFLATIONRATE + 1.0))
            
            
            let payInt = payDouble.rounded();
            
            retirementPay.append(Int(payInt))
            
            i+=1;
        }

        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func getEffectiveROR(preTax:Double) -> Double{
        let posh = 0.8*preTax
        let pos = posh/100
        let eROR = (1 + pos)/(1 + INFLATIONRATE) - 1;
        
    //    print(eROR)
        return eROR;
     
        
    }
    
    @IBAction func getValue(_ sender: Any) {
        
        getPV();
        
        makeLineGraph();
        
    }
    func getPV(){
        let preTaxRate :Double? = Double(preTaxRateField.text!)
        
        let add = getEffectiveROR(preTax:preTaxRate ?? 0);
        
        let years : Int? = Int(yearsInRetirement.text!);
        let month : Int? =  Int(monthlyExpenses.text!);
        let monthly = 12 * (month ?? 0)
        presentValue(rate: add, numberOfPeriod: years ?? 0, payment: -(monthly ?? 0));
        
        
        
    }
    
    
    func presentValue(rate:Double, numberOfPeriod: Int, payment: Int){
        
        let t = true;
        let r1 = rate + 1;
        let retval = ((1 - (pow(r1, Double(numberOfPeriod)))) / (rate) )
        var retval2 = 0.0;
        print(retval)


        if(t){
            
            retval2 = (r1 * Double(payment) - 0)
            
        }else{
            
            retval2 = Double((1 * payment - 0))
            
        }




        let retval3 = (retval2) / (pow((r1), Double(numberOfPeriod)))


        var value = retval * retval3
        value = value.rounded();
        let intValue = Int(value)
        totalLabel.text = String(intValue.withCommas())
        
    }

}

