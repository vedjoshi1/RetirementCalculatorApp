//
//  BoringTableViewCell.swift
//  RetirementCalculator
//
//  Created by Ved Joshi on 7/22/21.
//

import UIKit

class BoringTableViewCell: UITableViewCell {

  
    @IBOutlet weak var tabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
