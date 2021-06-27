//
//  FoodDetailDM.swift
//  FoodyCook
//
//  Created by auriga on 6/27/21.
//
// MARK: - FoodDetailDM
struct FoodDetailDM: Codable {
    var meals: [Meal]?
}

// MARK: - Meal
struct Meal: Codable, Hashable, Equatable  {
    let idMeal, strMeal, strCategory, strArea: String?
    let strMealThumb, strTags, strYoutube, strIngredient1: String?
    let strIngredient2, strIngredient3, strIngredient4, strIngredient5: String?
    let strIngredient6, strIngredient7, strIngredient8, strIngredient9: String?
    let strIngredient10, strIngredient11, strIngredient12, strIngredient13: String?
    let strIngredient14, strIngredient15, strIngredient16, strIngredient17: String?
    let strIngredient18, strIngredient19, strIngredient20, strMeasure1: String?
    let strMeasure2, strMeasure3, strMeasure4, strMeasure5: String?
    let strMeasure6, strMeasure7, strMeasure8, strMeasure9: String?
    let strMeasure10, strMeasure11, strMeasure12, strMeasure13: String?
    let strMeasure14, strMeasure15, strMeasure16, strMeasure17: String?
    let strMeasure18, strMeasure19, strMeasure20, strSource, strInstructions: String?
}
