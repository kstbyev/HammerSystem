import Foundation

protocol NetworkServiceProtocol {
    func checkConnection() async -> Bool
    func fetchMeals(searchTerm: String) async throws -> [Meal]
    func fetchCocktails(searchTerm: String) async throws -> [Cocktail]
}

final class NetworkService: NetworkServiceProtocol {
    private let session = URLSession.shared
    
    func checkConnection() async -> Bool {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else { return false }
        
        do {
            let (_, response) = try await session.data(from: url)
            return (response as? HTTPURLResponse)?.statusCode == 200
        } catch {
            return false
        }
    }
    
    func fetchMeals(searchTerm: String) async throws -> [Meal] {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchTerm)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await session.data(from: url)
        let response = try JSONDecoder().decode(MealResponse.self, from: data)
        return response.meals ?? []
    }
    
    func fetchCocktails(searchTerm: String) async throws -> [Cocktail] {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(searchTerm)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await session.data(from: url)
        let response = try JSONDecoder().decode(CocktailResponse.self, from: data)
        return response.drinks ?? []
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
} 