//
//  Anime.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.08.2024.
//

struct Anime: Decodable {
    let id: Int
    let name: String
    let russian: String
    let image: Image
    let url: String
    let kind: String
    let score: String
    let status: String
    let episodes: Int
    let episodes_aired: Int
    let aired_on: String
    let released_on: String
}

struct Image: Decodable {
    let original: String
    let preview: String
    let x96: String
    let x48: String
}
