import Foundation

protocol CacheServiceProtocol {
    func save<T: Codable>(_ items: [T], forKey key: String)
    func load<T: Codable>(_ type: T.Type, forKey key: String) -> [T]?
    func hasCachedData() -> Bool
    func updateLastSyncDate()
}

final class CacheService: CacheServiceProtocol {
    private let userDefaults = UserDefaults.standard
    
    private enum CacheKeys {
        static let combos = "cached_combos"
        static let desserts = "cached_desserts" 
        static let drinks = "cached_drinks"
        static let lastUpdate = "last_api_update"
    }
    
    func save<T: Codable>(_ items: [T], forKey key: String) {
        guard let data = try? JSONEncoder().encode(items) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func load<T: Codable>(_ type: T.Type, forKey key: String) -> [T]? {
        guard let data = userDefaults.data(forKey: key),
              let items = try? JSONDecoder().decode([T].self, from: data) else { return nil }
        return items
    }
    
    func hasCachedData() -> Bool {
        return userDefaults.data(forKey: CacheKeys.combos) != nil ||
               userDefaults.data(forKey: CacheKeys.desserts) != nil ||
               userDefaults.data(forKey: CacheKeys.drinks) != nil
    }
    
    func updateLastSyncDate() {
        userDefaults.set(Date(), forKey: CacheKeys.lastUpdate)
    }
} 