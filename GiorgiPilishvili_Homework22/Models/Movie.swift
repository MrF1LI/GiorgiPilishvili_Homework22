//
//  Movie.swift
//  GiorgiPilishvili_Homework22
//
//  Created by GIORGI PILISSHVILI on 13.08.22.
//

import Foundation

struct MovieResponseData: Codable {
    
    struct Movie: Codable {
        
        enum CodingKeys: String, CodingKey {
            case id, name, overview//, status, type
            case firstAirDate = "first_air_date"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case imageUrl = "poster_path"
        }
        
        let id: Int
        let name: String
        let overview: String
        let firstAirDate: String
        let imageUrl: String
        let voteAverage: Float
        let voteCount: Int
        
    }
    
    // Movie Response Data
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    let page: Int
    let movies: [Movie]
    let totalPages: Int
    let totalResults: Int
}

struct GuestSession: Codable {
    
    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionId = "guest_session_id"
        case expiresAt = "expires_at"
    }
    
    let success: Bool
    let guestSessionId: String
    let expiresAt: String
    
}

struct MovieDetails: Codable {
    
    struct Company: Codable {
        
        enum CodingKeys: String, CodingKey {
            case id, name
            case logoUrl = "logo_path"
            case originCountry = "origin_country"
        }
        
        let id: Int
        let name: String
        let logoUrl: String?
        let originCountry: String
    }
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    // Movie Details
    
    enum CodingKeys: String, CodingKey {
        case type, genres, status
        case productionCompanies = "production_companies"
    }
    
    let type: String
    let genres: [Genre]?
    let status: String
    let productionCompanies: [Company]?
    
}

struct RateResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
    let statusCode: Int
    let statusMessage: String
    
}
