//
//  UserRateGraphQL.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 15.02.2025.
//

import Foundation
import ShikimoriAPI

protocol UserRateProtocol {
    var id: ShikimoriAPI.ID { get }
    var episodes: Int { get }
    var rewatches: Int { get }
    var score: Int { get }
    var status: GraphQLEnum<ShikimoriAPI.UserRateStatusEnum> { get }
    var animeData: UserRateAnimeProtocol? { get }
}

struct UserRateGraphQL: UserRateProtocol {
    var id: ShikimoriAPI.ID
    var episodes: Int
    var rewatches: Int
    var score: Int
    var status: GraphQLEnum<ShikimoriAPI.UserRateStatusEnum>
    var animeData: UserRateAnimeProtocol?
    
    init(from userRate: UserRateProtocol) {
        id = userRate.id
        episodes = userRate.episodes
        rewatches = userRate.rewatches
        score = userRate.score
        status = userRate.status
        animeData = userRate.animeData
    }
}

extension UserRatesQuery.Data.UserRate: UserRateProtocol {
    var id: ShikimoriAPI.ID { __data["id"] }
    var episodes: Int { __data["episodes"] }
    var rewatches: Int { __data["rewatches"] }
    var score: Int { __data["score"] }
    var status: ApolloAPI.GraphQLEnum<ShikimoriAPI.UserRateStatusEnum> { __data["status"] }
    var animeData: UserRateAnimeProtocol? {
        guard let anime = self.anime else { return nil }
        return UserRateAnime(from: anime)
    }
}

extension AnimeDetailsQuery.Data.Anime.UserRate: UserRateProtocol {
    var id: ShikimoriAPI.ID { __data["id"] }
    var episodes: Int { __data["episodes"] }
    var rewatches: Int { __data["rewatches"] }
    var score: Int { __data["score"] }
    var status: ApolloAPI.GraphQLEnum<ShikimoriAPI.UserRateStatusEnum> { __data["status"] }
    var animeData: UserRateAnimeProtocol? {
        guard let anime = self.anime else { return nil }
        return UserRateAnime(from: anime)
    }
}

protocol UserRateAnimeProtocol {
    var id: ShikimoriAPI.ID { get }
    var name: String { get }
    var english: String? { get }
    var russian: String? { get }
    var episodes: Int { get }
    var episodesAired: Int { get }
    var score: Double? { get }
    var season: String? { get }
    var status: GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>? { get }
    var kind: GraphQLEnum<ShikimoriAPI.AnimeKindEnum>? { get }
    var posterUrl: String? { get }
    var airedOnYear: Int? { get }
}

struct UserRateAnime: UserRateAnimeProtocol {
    var id: ShikimoriAPI.ID
    var name: String
    var english: String?
    var russian: String?
    var episodes: Int
    var episodesAired: Int
    var score: Double?
    var season: String?
    var status: GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>?
    var kind: GraphQLEnum<ShikimoriAPI.AnimeKindEnum>?
    var posterUrl: String?
    var airedOnYear: Int?

    init(from anime: UserRatesQuery.Data.UserRate.Anime) {
        id = anime.id
        name = anime.name
        english = anime.english
        russian = anime.russian
        episodes = anime.episodes
        episodesAired = anime.episodesAired
        score = anime.score
        season = anime.season
        status = anime.status
        kind = anime.kind
        posterUrl = anime.poster?.mainUrl
        airedOnYear = anime.airedOn?.year
    }

    init(from anime: AnimeDetailsQuery.Data.Anime.UserRate.Anime) {
        id = anime.id
        name = anime.name
        english = anime.english
        russian = anime.russian
        episodes = anime.episodes
        episodesAired = anime.episodesAired
        score = anime.score
        season = anime.season
        status = anime.status
        kind = anime.kind
        posterUrl = anime.poster?.mainUrl
        airedOnYear = anime.airedOn?.year
    }
}


extension UserRatesQuery.Data.UserRate.Anime: UserRateAnimeProtocol {
    var posterUrl: String? { self.poster?.mainUrl }
    var airedOnYear: Int? { self.airedOn?.year }
}

