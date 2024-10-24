//
//  AnimeDetailsViewModel.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 18.10.2024.
//

import Foundation
import Alamofire

protocol AnimeDetailsViewModelProtocol {
    var posterUrl: URL { get }
    var type: String { get }
    var episodes: String { get }
    var episodeDuration: String { get }
    var status: String { get }
    var genres: String { get }
    var rating: String { get }
    
    func fetchAnimeDetails(completion: @escaping() -> Void)
    init(animeId: Int, user: User?)
}

final class AnimeDetailsViewModel: AnimeDetailsViewModelProtocol {
    var posterUrl: URL {
        URL(string: "https://desu.shikimori.one\(anime.image.original)")!
    }
    
    var type: String {
        "Тип: \(anime.kind ?? "")"
    }
    
    var episodes: String {
        "Эпизоды: \(anime.episodesAired) из \(anime.episodes == 0 ? "?" : "\(anime.episodes)")"
    }

    var episodeDuration: String {
        "Длительность эпизода: \(anime.duration) мин."
    }
    
    var status: String {
        if anime.status == "ongoing" {
            return "Статус: \(anime.statusLocalized) c \(dateLocalized(from: anime.airedOn ?? ""))"
        } else if anime.status == "released" {
            return "Статус: \(anime.statusLocalized) c \(dateLocalized(from: anime.airedOn ?? "")) по \(dateLocalized(from: anime.releasedOn ?? ""))"
        } else {
            return "Статус: \(anime.statusLocalized)"
        }
    }
    
    var genres: String {
        "Жанры: \(anime.genres.reduce("") { $0 + ", " + $1.russian })"
    }
    
    var rating: String {
        "Рейтинг: \(anime.rating)"
    }
    
    private var anime: AnimeDetails!
    private let user: User?
    private let animeId: Int
    
    private let networkManager = NetworkManager.shared
    
    func fetchAnimeDetails(completion: @escaping () -> Void) {
        let fetchFunction: (URLConvertible, Parameters?, @escaping (Result<AnimeDetails, AFError>) -> Void) -> Void
        fetchFunction = { url, parameters, completion in
            if self.user != nil {
                self.networkManager.fetchWithAuthorization(
                    AnimeDetails.self,
                    from: url,
                    withParameters: parameters,
                    completion: completion
                )
            } else {
                self.networkManager.fetchWithoutAuthorization(
                    AnimeDetails.self,
                    from: url,
                    withParameters: parameters,
                    completion: completion
                )
            }
        }
        fetchFunction(
            "https://shikimori.one/api/animes/\(animeId)",
            nil
        ) { [unowned self] result in
                switch result {
                case .success(let anime):
                    self.anime = anime
                    completion()
                case .failure(let error):
                    print(error)
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
