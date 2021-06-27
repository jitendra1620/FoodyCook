//
//  DetailAttributeTableViewCell.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//

import UIKit

class DetailAttributeTableViewCell: UITableViewCell {

    @IBOutlet weak var btnYoutube: UIButton!
    @IBOutlet weak var nameCategory: UILabel!
    @IBOutlet weak var lblName: UILabel!
    var mealDetail:Meal?{
        didSet{
            self.btnYoutube.setTitle(self.mealDetail?.strYoutube ?? "", for: .normal)
            self.nameCategory.text = self.mealDetail?.strCategory ?? ""
            self.lblName.text = self.mealDetail?.strMeal ?? ""
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
