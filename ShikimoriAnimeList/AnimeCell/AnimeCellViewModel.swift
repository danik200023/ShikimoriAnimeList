//
//  AnimeCellViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 23.10.2024.
//

import Foundation

protocol AnimeCellViewModelProtocol {
    var animeName: String { get }
    var numberOfEpisodes: String { get }
    var posterUrl: URL { get }
    init(anime: Anime)
}

final class AnimeCellViewModel: AnimeCellViewModelProtocol {
    var animeName: String {
        anime.russian != "" ? anime.russian : anime.name
    }
    
    var numberOfEpisodes: String {
        "[\(anime.episodesAired) из \(anime.episodes == 0 ? "?" : "\(anime.episodes)")]"
    }
    
    var posterUrl: URL {
        URL(string: "https://desu.shikimori.one\(anime.image.original)")!
    }
    
    private let anime: Anime
    
    required init(anime: Anime) {
        self.anime = anime
    }
}
