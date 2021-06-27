//
//  DetailInstructionTableViewCell.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//

import UIKit

class DetailInstructionTableViewCell: UITableViewCell {
    var mealDetail:Meal?{
        didSet{
            self.lblInstruction.text = self.mealDetail?.strInstructions ?? ""
        }
    }
    @IBOutlet weak var lblInstruction: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
