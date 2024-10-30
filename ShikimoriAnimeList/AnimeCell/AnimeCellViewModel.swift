//
//  AnimeCellViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 23.10.2024.
//

import Foundation
import ShikimoriAPI

protocol AnimeCellViewModelProtocol {
    var animeName: String { get }
    var numberOfEpisodes: String { get }
    var animeId: Int { get }
    var posterUrl: URL { get }
    init(anime: AnimeSearchQuery.Data.Anime)
}

final class AnimeCellViewModel: AnimeCellViewModelProtocol {
    var animeName: String {
        anime.russian ?? anime.name
    }
    
    var numberOfEpisodes: String {
        if anime.status == .released {
            return "\(anime.episodes)"
        } else {
            return "[\(anime.episodesAired) из \(anime.episodes == 0 ? "?" : "\(anime.episodes)")]"
        }
        
    }
    
    var animeId: Int {
        Int(anime.id) ?? 0
    }
    
    var posterUrl: URL {
        return URL(string: anime.poster?.mainUrl ?? "https://shikimori.one/assets/globals/missing/main@2x.png")!
    }
    
    private let anime: AnimeSearchQuery.Data.Anime
    
    required init(anime: AnimeSearchQuery.Data.Anime) {
        self.anime = anime
    }
}
