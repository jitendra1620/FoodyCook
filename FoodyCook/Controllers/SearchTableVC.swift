//
//  SearchTableVC.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//

import UIKit

class SearchTableVC: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var arrMeal:[Meal] = [Meal](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var isToViewSavedItem = false
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.isEnabled = !isToViewSavedItem

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMeal.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.arrMeal[safe: indexPath.row]?.strMeal
        cell.imageView?.setKFImage(strUrl: self.arrMeal[safe: indexPath.row]?.strMealThumb ?? "")
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FoodVCDetailVC.instantiate(fromStoryboard: .main)
        vc.idToSearch = self.arrMeal[safe: indexPath.row]?.idMeal ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(strMesage:String) {
        let alert = UIAlertController(title: "Alert", message: strMesage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - APICALLing
extension SearchTableVC{
    /// Web Service to fetch detail food meet data from apu
    /// - Parameter id: food if will be null in case of random food fetch
    func callWebServiceToFetchFood(str search:String) {
        let strURl = APIAddress.WithName.rawValue + search
        NetworkManager.makeRequest(forStringUrl: strURl) { (response) in
            switch response {
            case .success(let result):
                do {
                    self.arrMeal = try JSONDecoder().decode(FoodDetailDM.self, from: result ?? Data()).meals ?? []
                } catch let error {
                    print(error)
                }
                break
            case .failure(let error):
                self.showAlert(strMesage: error.localizedDescription)
            }
        }
    }
    
}
extension SearchTableVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.callWebServiceToFetchFood(str: searchText)
    }
}
