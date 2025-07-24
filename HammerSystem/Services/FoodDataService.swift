import Foundation

protocol FoodDataServiceProtocol {
    func loadData() async
    func getCombos() -> [FoodItem]
    func getDesserts() -> [FoodItem]
    func getDrinks() -> [FoodItem]
    func isOfflineMode() -> Bool
}

@MainActor
final class FoodDataService: ObservableObject, FoodDataServiceProtocol {
    @Published private(set) var combos: [FoodItem] = []
    @Published private(set) var desserts: [FoodItem] = []
    @Published private(set) var drinks: [FoodItem] = []
    @Published private(set) var isOffline = false
    
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService(),
         cacheService: CacheServiceProtocol = CacheService()) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func loadData() async {
        let hasConnection = await networkService.checkConnection()
        
        if hasConnection {
            combos.removeAll()
            desserts.removeAll()
            drinks.removeAll()
            
            await fetchFromAPI()
            saveToCache()
            isOffline = false
        } else {
            loadCachedData()
            isOffline = cacheService.hasCachedData()
        }
    }
    
    func getCombos() -> [FoodItem] { combos }
    func getDesserts() -> [FoodItem] { desserts }
    func getDrinks() -> [FoodItem] { drinks }
    func isOfflineMode() -> Bool { isOffline }
    
    private func loadCachedData() {
        combos = cacheService.load(FoodItem.self, forKey: "cached_combos") ?? []
        desserts = cacheService.load(FoodItem.self, forKey: "cached_desserts") ?? []
        drinks = cacheService.load(FoodItem.self, forKey: "cached_drinks") ?? []
    }
    
    private func fetchFromAPI() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.loadDrinks() }
            group.addTask { await self.loadDesserts() }
            group.addTask { await self.loadCombos() }
        }
    }
    
    private func saveToCache() {
        cacheService.save(combos, forKey: "cached_combos")
        cacheService.save(desserts, forKey: "cached_desserts")
        cacheService.save(drinks, forKey: "cached_drinks")
        cacheService.updateLastSyncDate()
    }
    
    private func loadDrinks() async {
        do {
            let cocktails = try await networkService.fetchCocktails(searchTerm: "Coca Cola")
            if let cocktail = cocktails.first {
                let cocaCola = FoodItem(
                    name: "Кока-Кола",
                    description: "Классический напиток 0.5л",
                    price: 99,
                    image: cocktail.strDrinkThumb ?? "",
                    category: "Напитки"
                )
                drinks.append(cocaCola)
            }
            
            let orangeDrinks = try await networkService.fetchCocktails(searchTerm: "Orange")
            if let orange = orangeDrinks.first {
                let orangeJuice = FoodItem(
                    name: "Апельсиновый сок",
                    description: "Свежевыжатый сок 0.3л",
                    price: 149,
                    image: orange.strDrinkThumb ?? "",
                    category: "Напитки"
                )
                drinks.append(orangeJuice)
            }
        } catch {
            print("Failed to load drinks: \(error)")
        }
    }
    
    private func loadDesserts() async {
        do {
            let tiramisu = try await networkService.fetchMeals(searchTerm: "Tiramisu")
            if let meal = tiramisu.first {
                let tiramisuItem = FoodItem(
                    name: "Тирамису",
                    description: "Классический итальянский десерт",
                    price: 199,
                    image: meal.strMealThumb ?? "",
                    category: "Десерты"
                )
                desserts.append(tiramisuItem)
            }
            
            let cheesecake = try await networkService.fetchMeals(searchTerm: "Cheesecake")
            if let meal = cheesecake.first {
                let cheesecakeItem = FoodItem(
                    name: "Чизкейк",
                    description: "Нежный творожный торт",
                    price: 179,
                    image: meal.strMealThumb ?? "",
                    category: "Десерты"
                )
                desserts.append(cheesecakeItem)
            }
        } catch {
            print("Failed to load desserts: \(error)")
        }
    }
    
    private func loadCombos() async {
        do {
            let lasagne = try await networkService.fetchMeals(searchTerm: "Lasagne")
            if let meal = lasagne.first {
                let familyCombo = FoodItem(
                    name: "Комбо Семейное",
                    description: "2 пиццы + напитки + закуски",
                    price: 1299,
                    image: meal.strMealThumb ?? "",
                    category: "Комбо"
                )
                combos.append(familyCombo)
            }
            
            let pizza = try await networkService.fetchMeals(searchTerm: "Pizza")
            if let meal = pizza.first {
                let coupleCombo = FoodItem(
                    name: "Комбо для двоих",
                    description: "1 большая пицца + 2 напитка",
                    price: 799,
                    image: meal.strMealThumb ?? "",
                    category: "Комбо"
                )
                combos.append(coupleCombo)
            }
        } catch {
            print("Failed to load combos: \(error)")
        }
    }
} 