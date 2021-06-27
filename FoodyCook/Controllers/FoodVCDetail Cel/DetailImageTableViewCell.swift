//
//  DetailImageTableViewCell.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {
    var mealDetail:Meal?{
        didSet{
            self.imgvDetail.setKFImage(strUrl: self.mealDetail?.strMealThumb ?? "")
        }
    }
    @IBOutlet weak var imgvDetail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
