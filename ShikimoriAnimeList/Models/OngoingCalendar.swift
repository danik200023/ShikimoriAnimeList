//
//  OngoingCalendar.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 25.10.2024.
//

import Foundation

struct OngoingCalendar: Decodable {
    let nextEpisode: Int
    let nextEpisodeAt: String
    let duration: Int?
    let anime: Anime
}
