//
//  DetailIngredientTableViewCell.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//

import UIKit

class DetailIngredientTableViewCell: UITableViewCell {
    var mealDetail:Meal?{
        didSet{
            self.updateUIData()
        }
    }
    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUIData() {
        guard let data = self.mealDetail else { return }
        if let strTile = data.strIngredient1, let strQty = data.strMeasure1, !strTile.isEmpty{
            addStackView(strTile: strTile, strQty: strQty)
        }
        let arrStrIngredent = [data.strIngredient1,data.strIngredient2,data.strIngredient3,data.strIngredient4,data.strIngredient5,data.strIngredient6,data.strIngredient7,data.strIngredient8,data.strIngredient9,data.strIngredient10,data.strIngredient11,data.strIngredient12,data.strIngredient13,data.strIngredient14,data.strIngredient15,data.strIngredient16,data.strIngredient17,data.strIngredient18,data.strIngredient19,data.strIngredient20]
        let arrStrMeasure = [data.strMeasure1,data.strMeasure2,data.strMeasure3,data.strMeasure4,data.strMeasure5,data.strMeasure6,data.strMeasure7,data.strMeasure8,data.strMeasure9,data.strMeasure10,data.strMeasure11,data.strMeasure12,data.strMeasure13,data.strMeasure14,data.strMeasure15,data.strMeasure16,data.strMeasure17,data.strMeasure18,data.strMeasure19,data.strMeasure20]
        _ = arrStrIngredent.enumerated().map({ (inex, strIngredent) -> Void in
            if let strQty = arrStrMeasure[safe:inex], !(strIngredent?.isEmpty ?? true){
                addStackView(strTile: strIngredent ?? "", strQty: strQty ?? "")
            }
        })
        
        
    }
    func addStackView(strTile:String, strQty:String) {
        
        let stackViewT = UIStackView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 21))
        stackViewT.translatesAutoresizingMaskIntoConstraints = false
        stackViewT.axis = .horizontal
        stackViewT.distribution = .fillEqually
        let lblOne = UILabel.init()
        lblOne.text = strTile
        let lblTwo = UILabel.init()
        lblTwo.text = strQty
        stackViewT.addArrangedSubview(lblOne)
        stackViewT.addArrangedSubview(lblTwo)
        self.stackView.addArrangedSubview(stackViewT)
    }
}
