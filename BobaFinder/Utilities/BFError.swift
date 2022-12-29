//
//  BFError.swift
//  BobaFinder
//
//  Created by Eric Liang on 12/23/22.
//

import Foundation

enum BFError: String, Error {
    case invalidZipcode = "This zipcode created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this place. Please try again."
    case alreadyInFavorites = "You've already favorited this place."

}
