//
//  AnimeDetailsViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 18.10.2024.
//

import Foundation
import Alamofire
import ShikimoriAPI

protocol AnimeDetailsViewModelProtocol {
    var posterUrl: URL { get }
    var russianName: String? { get }
    var name: String { get }
    var type: String { get }
    var episodes: String { get }
    var episodeDuration: String { get }
    var statusDetails: String? { get }
    var status: String { get }
    var genres: String { get }
    var rating: String { get }
    var description: String { get }
    
     func fetchAnimeDetails(completion: @escaping() -> Void)
    init(animeId: Int, user: User?)
}

final class AnimeDetailsViewModel: AnimeDetailsViewModelProtocol {
    var russianName: String? {
        anime.russian
    }
    
    var name: String {
        anime.name
    }
    
    var posterUrl: URL {
        URL(string: anime.poster?.mainUrl ?? "https://shikimori.one/assets/globals/missing/main@2x.png")!
    }
    
    var type: String {
        switch anime.kind?.value {
        case .tv:
            return "TV"
        case .movie:
            return "Фильм"
        case .ova:
            return "OVA"
        case .ona:
            return "ONA"
        case .special:
            return "Спецвыпуск"
        case .tvSpecial:
            return "TV спецвыпуск"
        case .music:
            return "Клип"
        case .pv:
            return "Проморолик"
        case .cm:
            return "Реклама"
        case .none:
            return ""
        }
    }
    
    var episodes: String {
        switch anime.status?.value {
        case .released:
            return "\(anime.episodes)"
        case .ongoing:
            return "\(anime.episodesAired)/\(anime.episodes == 0 ? "-" : "\(anime.episodes)")"
        default:
            return ""
        }
    }

    var episodeDuration: String {
        "\(anime.duration ?? 0) мин."
    }
    
    var statusDetails: String? {
        switch anime.status?.value {
        case .ongoing:
            return "Онгоинг c \(dateLocalized(from: anime.airedOn?.date ?? ""))"
        case .released:
            return "c \(dateLocalized(from: anime.airedOn?.date ?? "")) по \(dateLocalized(from: anime.releasedOn?.date ?? ""))"
        default:
            return "Анонс"
        }
    }
    
    var status: String {
        switch anime.status?.value {
        case .released:
            return "Даты выхода"
        default:
            return "Статус"
        }
    }
    
    var genres: String {
        ""
    }
    
    var rating: String {
        ""
    }
    
    var description: String {
        guard let input = anime.description else { return "" }
        let pattern = "\\[(\\w+)(?:=[^\\]]+)?\\](.*?)\\[/\\1\\]"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])

        var output = input
        while let match = regex.firstMatch(in: output, options: [], range: NSRange(output.startIndex..<output.endIndex, in: output)) {
            let range = match.range(at: 0)
            let contentRange = match.range(at: 2)
            
            if let range = Range(range, in: output), let contentRange = Range(contentRange, in: output) {
                let content = output[contentRange]
                output.replaceSubrange(range, with: content)
            }
        }

        return output
    }
    
    private var anime: AnimeDetailsQuery.Data.Anime!
    private let user: User?
    private let animeId: Int
    
    private let networkManager = NetworkManager.shared
    
    func fetchAnimeDetails(completion: @escaping () -> Void) {
        networkManager.fetchAnimeDetails(animeId: animeId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let value):
                anime = value.data?.animes.first
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    init(animeId: Int, user: User? = nil) {
        self.animeId = animeId
        self.user = user
    }
    
    private func dateLocalized(from date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: date) else { return date }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMM yyyy"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        return outputFormatter.string(from: date)
    }
}
