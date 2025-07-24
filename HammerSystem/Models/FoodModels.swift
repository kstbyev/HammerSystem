import Foundation

struct FoodItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let price: Int
    let image: String
    let category: String
}

struct MealResponse: Codable {
    let meals: [Meal]?
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
}

struct CocktailResponse: Codable {
    let drinks: [Cocktail]?
}

struct Cocktail: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String?
    let strInstructions: String?
} 