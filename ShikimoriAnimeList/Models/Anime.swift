//
//  Anime.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.08.2024.
//

import Foundation

struct Anime: Decodable {
    let id: Int
    let name: String
    let russian: String
    let image: AnimeImage
    let url: URL
    let kind: String?
    let score: String
    let status: String
    let episodes: Int
    let episodesAired: Int
    let airedOn: String?
    let releasedOn: String?
}

struct AnimeImage: Decodable {
    let original: URL
    let preview: URL
    let x96: URL
    let x48: URL
}
