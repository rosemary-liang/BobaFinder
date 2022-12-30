//
//  PersistenceManager.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/29/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

// use enum instead of struct because enum cannot initialize an empty enum
// struct can initialize empty struct
enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func updateWith(favorite: Place, actionType: PersistenceActionType, completed: @escaping (BFError?) -> Void) {
        retrieveFavorites { result  in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.fsqID == favorite.fsqID }
                }
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[Place], BFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([])) // empty array because no favorites yet
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let places = try decoder.decode([Place].self, from: favoritesData)
            completed(.success(places))
        } catch {
            completed(.failure(.unableToComplete))
        }
    }
    
    
    static func save(favorites: [Place]) -> BFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
