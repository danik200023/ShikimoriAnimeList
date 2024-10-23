//
//  User.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 25.09.2024.
//

import Foundation

struct User: Decodable {
    let id: Int
    let nickname: String
    let avatar: URL
    let image: ProfileImage
    let lastOnlineAt: String
    let url: URL
    let name: String?
    let sex: String?
    let website: String?
    let birthOn: String?
    let fullYears: Int?
    let locale: String
}

struct ProfileImage: Decodable {
    let x160: URL
    let x148: URL
    let x80: URL
    let x64: URL
    let x48: URL
    let x32: URL
    let x16: URL
}
