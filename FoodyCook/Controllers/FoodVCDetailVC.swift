//
//  RandomFoodVC.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//

import UIKit
import SafariServices
class FoodVCDetailVC: BaseViewController {

    
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    @IBOutlet weak var btnSearch: UIBarButtonItem!
    @IBOutlet weak var btnViewSavedItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    
    
    var isToFetchRandom = true //To check if for random fetch or with Id fetch
    var idToSearch:String?
    var mealsDetail:Meal?{
        didSet {
            self.tableView != nil ? self.tableView.reloadData() : nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callWebServiceToFetchFood(for: idToSearch)
        if idToSearch != nil{
            btnViewSavedItem.isEnabled = false
            btnSearch.image = .remove
        }
    }
    @IBAction func btnAddClicked(_ sender: Any) {
        guard let detail = self.mealsDetail else { return }
        var arrMeal = UserDefaultManager.getArrMeal()
        arrMeal.append(detail)
        let data = FoodDetailDM.init(meals:arrMeal)
        UserDefaultManager.saveArrMeal(data: data)
        self.showAlert(strMesage: "Saved succesfully")
    }
    @IBAction func btnViewSavedItemClicked(_ sender: Any) {
        let vc = SearchTableVC.instantiate(fromStoryboard: .main)
        vc.isToViewSavedItem =  true
        vc.arrMeal = UserDefaultManager.getArrMeal()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func btnSearchClicked(_ sender: Any) {
        if idToSearch != nil{
            var arrMeal = UserDefaultManager.getArrMeal()
            arrMeal = arrMeal.filter({$0.idMeal != self.mealsDetail?.idMeal ?? ""})
            let data = FoodDetailDM.init(meals:arrMeal)
            UserDefaultManager.saveArrMeal(data: data)
            self.showAlert(strMesage: "Item removed from saved items succesfully")
            return
        }
        let vc = SearchTableVC.instantiate(fromStoryboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func btnYoutubeClicked(_ sender: UIButton) {
        if let strURl = self.mealsDetail?.strYoutube, let url = URL(string: strURl) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
    }
    
}
//MARK: - API calling
extension FoodVCDetailVC {
    /// Web Service to fetch detail food meet data from apu
    /// - Parameter id: food if will be null in case of random food fetch
    func callWebServiceToFetchFood(for id:String?) {
        let strURl = id == nil ? APIAddress.random.rawValue : APIAddress.WithId.rawValue + "\(id ?? "")"
        self.showActivityIndecator()
        NetworkManager.makeRequest(forStringUrl: strURl) { (response) in
            self.hideActivityIndecator()
            switch response {
            case .success(let result):
                do {
                    self.mealsDetail = try JSONDecoder().decode(FoodDetailDM.self, from: result ?? Data()).meals?.first
                } catch let error {
                    print(error)
                }
                break
            case .failure(let error):
                self.showAlert(strMesage: error.localizedDescription)
            }
        }
    }
    func showAlert(strMesage:String) {
        let alert = UIAlertController(title: "Alert", message: strMesage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension FoodVCDetailVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailImageTableViewCell.self), for: indexPath) as? DetailImageTableViewCell
            cell?.mealDetail = self.mealsDetail
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailAttributeTableViewCell.self), for: indexPath) as? DetailAttributeTableViewCell
            cell?.mealDetail = self.mealsDetail
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailIngredientTableViewCell.self), for: indexPath) as? DetailIngredientTableViewCell
            cell?.mealDetail = self.mealsDetail
            return cell ?? UITableViewCell()
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailInstructionTableViewCell.self), for: indexPath) as? DetailInstructionTableViewCell
            cell?.mealDetail = self.mealsDetail
            return cell ?? UITableViewCell()
        }
        
    }
    
    
}
extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
