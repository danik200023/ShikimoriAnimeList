//
//  AnimeDetails.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 18.10.2024.
//

import Foundation

struct AnimeDetails: Decodable {
    let id: Int
    let name: String
    let russian: String
    let image: AnimeImage
    let url: String
    let kind: String?
    let score: String
    let status: String
    let episodes: Int
    let episodesAired: Int
    let airedOn: String?
    let releasedOn: String?
    let rating: String
    let english: [String]
    let japanese: [String]
    let synonyms: [String]
    let licenseNameRu: String?
    let duration: Int
    let description: String?
    let descriptionHtml: String
    let descriptionSource: String?
    let franchise: String?
    let favoured: Bool
    let anons: Bool
    let ongoing: Bool
    let threadId: Int
    let topicId: Int
    let myanimelistId: Int
    let ratesScoresStats: [RateScoreStat]
    let ratesStatusesStats: [RateStatusStat]
    let updatedAt: String
    let nextEpisodeAt: String?
    let fansubbers: [String]
    let fandubbers: [String]
    let licensors: [String]
    let genres: [Genre]
    let studios: [Studio]
    let videos: [Video]
    let screenshots: [Screenshot]
    let userRate: String?
    
    var statusLocalized: String {
        Status(rawValue: status)?.localized ?? "неизвестный статус"
    }
    
    enum Status: String {
        case anons
        case ongoing
        case released

        var localized: String {
            switch self {
            case .anons:
                return "анонс"
            case .ongoing:
                return "онгоинг"
            case .released:
                return "вышло"
            }
        }
    }
}

struct Genre: Decodable {
    let id: Int
    let name, russian, kind, entryType: String

}

struct RateScoreStat: Decodable {
    let name: Int
    let value: Int
}

struct RateStatusStat: Decodable {
    let name: String
    let value: Int
}

struct Screenshot: Decodable {
    let original, preview: String
}

struct Studio: Decodable {
    let id: Int
    let name, filteredName: String
    let real: Bool
    let image: String?
}

struct Video: Decodable {
    let id: Int
    let url, imageUrl, playerUrl, name: String
    let kind, hosting: String
}
