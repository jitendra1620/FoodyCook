//
//  UserDefaultManager.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//

import Foundation

class UserDefaultManager {
    
    static func saveArrMeal(data:FoodDetailDM) {
        var dataT = data
        dataT.meals = dataT.meals?.uniqued()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(dataT) {
            UserDefaults.standard.set(encoded, forKey: "ArrMeals")
        }
    }
    
    static func getArrMeal() -> [Meal] {
        if let arr = UserDefaults.standard.object(forKey: "ArrMeals") as? Data {
            let decoder = JSONDecoder()
            if let mealData = try? decoder.decode(FoodDetailDM.self, from: arr) {
                return mealData.meals ?? []
            }
        }
        return []
    }
}
