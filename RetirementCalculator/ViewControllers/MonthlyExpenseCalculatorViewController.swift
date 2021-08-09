//
//  MonthlyExpenseCalculatorViewController.swift
//  RetirementCalculator
//
//  Created by Ved Joshi on 6/27/21.
//

import UIKit

class MonthlyExpenseCalculatorViewController: UIViewController {
    let arr = ["Mortgage", "Property Tax", "Health Insurance", "Grocery", "Petrol", "Travel(average is 700$)", "Restaurants", "Gifts/Charity", "Utility Bills", "Registrations/Services", "Social Security", "Unexpected Costs", "Kids", "Other Stuff"];
    var i = 0;
    @IBOutlet weak var firstTableView: UITableView!
    
    @IBOutlet weak var boringTableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var totalValueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTableView.dataSource = self;
        boringTableView.dataSource = self;
        
        
        boringTableView.register(UINib(nibName: "BoringTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        firstTableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        

        // Do any additional setup after loading the view.
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let total = calculateExpenses();
        totalLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1);
        totalValueLabel.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1);
        totalValueLabel.text = String(total);
    }
    
    func calculateExpenses()-> Int{
        var i = 0;
        var count = 0;
        while(i < firstTableView.numberOfRows(inSection: 0)){
            let indexPath = IndexPath(row: i, section: 0)
            let tableViewCell = firstTableView.cellForRow(at: indexPath) as! TextFieldTableViewCell
            let num: Int?? = Int(tableViewCell.cellEnterText.text ?? "0") ?? 0;
            
          
                count+=(num ?? 0) ?? 0;
            i+=1;
        }
        
        return count;
        
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




extension MonthlyExpenseCalculatorViewController:UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        if(tableView == firstTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
                as! TextFieldTableViewCell
            
            return cell;
            
            
        }else if(tableView == boringTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
                as! BoringTableViewCell
            cell.tabel?.text = arr[i];
                i+=1;
            return cell;
            
            
        }else{
            
            return UITableViewCell();
        }
        
        
                
          
            
            
        
        
        
        
        
    }
}

