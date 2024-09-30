//
//  UserRate.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 27.09.2024.
//

import Foundation

struct UserRate: Decodable {
    let id: Int
    let userId: Int
    let targetId: Int
    let targetType: String
    let score: Int
    let status: String
    let rewatches: Int
    let episodes: Int
    let volumes: Int
    let chapters: Int
    let text: String?
    let textHtml: String
    let createdAt: String
    let updatedAt: String
    
    var statusLocalized: String {
        return Status(rawValue: status)?.localized ?? "Неизвестный статус"
    }
        
    
    enum Status: String {
        case planned = "planned"
        case watching = "watching"
        case rewatching = "rewatching"
        case completed = "completed"
        case onHold = "on_hold"
        case dropped = "dropped"
            
        var localized: String {
            switch self {
            case .planned:
                return "Запланировано"
            case .watching:
                return "Смотрю"
            case .rewatching:
                return "Пересматриваю"
            case .completed:
                return "Завершено"
            case .onHold:
                return "Отложено"
            case .dropped:
                return "Брошено"
            }
        }
    }
}
