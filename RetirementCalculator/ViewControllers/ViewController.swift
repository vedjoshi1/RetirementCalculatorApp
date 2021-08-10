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
    
  
    //ONLY FOR TESTING THIS IS NOWHERE NEAR ACCURATE
 //   let INFLATIONRATE = 0.02;
    
    
    //This is the line graph
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
    
    
    //This makes the line graph
    func makeLineGraph(intarr:  ([Int], [Int])){
        chartView.addSubview(lineChartView)
        
        
        lineChartView.centerInSuperview()
        
        lineChartView.width(to: chartView);
        lineChartView.height(to: chartView);
        setData(boom: intarr.1)
        
        
    }
    
    
    //just a delegate function, nothing here YET
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
     //   print(entry)
    }
    
    
    
    //THis sets the data for the line graph, and will need a LOT more stuff
    func setData(boom: [Int]){
        let yValues = generateValuesForGraph(nums: boom)
        let set1 = LineChartDataSet(entries: yValues, label: "Dollar")
        let data = LineChartData(dataSet: set1);
        lineChartView.data = data;
        
        
        
        
    }
    //I'd argue that this is self-explanatory
    func generateValuesForGraph(nums: [Int]) -> [ChartDataEntry]{
        //This is the values for the line graph, they will be moved to a function
        var yValues: [ChartDataEntry] = []
        
        
        var i = 1.0;
        for count in nums {
            yValues.append(ChartDataEntry(x:i, y:Double(count)));
            
            i+=1;
            
        }
        
        return yValues
    }
    //This generates both of the tables needed for the line graph
    func generateTable(corpus: Int, prate: Double, years: Int, monthly: Int)-> ([Int], [Int]){
   
        
        let rate = 0.8*prate
        
        
        let yearly = monthly*12;
        var retirementPay = [Int]()
        var corpusArr = [Int]()
        
        
        
        var i = 1;
        retirementPay.append(yearly);
        let firstCorpus = (Double(corpus - yearly) * (1.0 + rate))
        corpusArr.append(Int(firstCorpus));
        
        while(i <= years){
            let payDouble = ( Double(retirementPay[retirementPay.count - 1])  * (INFLATIONRATE + 1.0))
            
            
            let payInt = payDouble.rounded();
            
            retirementPay.append(Int(payInt))
            
            
            let corpusValuePostLoss = ( corpusArr[corpusArr.count - 1] - retirementPay[retirementPay.count-1])
            let corpusEndValueDouble = Double(corpusValuePostLoss) * (1+rate)
            
            
            
            let corpusInt = corpusEndValueDouble.rounded();
            if(corpusInt > 0){
            
                corpusArr.append(Int(corpusInt))
            
            
                i+=1;
               // print(i)
            }else{
                break;
                
            }
        }

        
    //    print(retirementPay)
        
  //      print(corpusArr)
        
        
        return (retirementPay, corpusArr)
        
    }
    
    
    
    
    
    
    
    
    
    //This gets the Effective Rate of Return
    func getEffectiveROR(preTax:Double) -> Double{
        let posh = 0.8*preTax
        let pos = posh/100
        let eROR = (1 + pos)/(1 + INFLATIONRATE) - 1;
        
    //    print(eROR)
        return eROR;
     
        
    }
    
    
    
    //THIS GUY KICKS EVERYTHING OFF!!!!
    //THE BIG BOY
    //This is called when the button is pressed
    @IBAction func getValue(_ sender: Any) {
        
        let bigCorpusAmount = getPV();
        
        
        let bigNum = generateTable(corpus: bigCorpusAmount.0, prate: bigCorpusAmount.3, years: bigCorpusAmount.1, monthly: bigCorpusAmount.2)
        
        makeLineGraph(intarr: bigNum);
        
    }
    
    
    //Gets the text and stuff for the big total corpus value amount
    func getPV()->(Int, Int, Int, Double){
        let preTaxRate :Double? = Double(preTaxRateField.text!)
   
        let add = getEffectiveROR(preTax:preTaxRate ?? 0);
        
        let years : Int? = Int(yearsInRetirement.text!);
        let month : Int? =  Int(monthlyExpenses.text!);
     //   print("MONTHMONTHMONTH" )
   //     print(month)
        let monthly = 12 * (month ?? 0)
        return (presentValue(rate: add, numberOfPeriod: years ?? 0, payment: -(monthly ?? 0)), years ?? 0, month ?? 0  ,  (preTaxRate ?? 0) / 100)
        
        
        
    }
    
    //this finds the big total corpus value amount
    func presentValue(rate:Double, numberOfPeriod: Int, payment: Int)->Int{
        
        let t = true;
        let r1 = rate + 1;
        let retval = ((1 - (pow(r1, Double(numberOfPeriod)))) / (rate) )
        var retval2 = 0.0;
    //    print(retval)


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
        return intValue
    }

}

