//
//  ViewController.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 13.08.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var animeLabel: UILabel!
    
    private let apiUrl = URL(
        string: "https://shikimori.one/api/animes?order=popularity&limit=10"
    )!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        animeLabel.text = ""
        fetchAnime()
    }
    
    private func fetchAnime() {
        URLSession.shared.dataTask(with: apiUrl) { [unowned self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let animes = try JSONDecoder().decode([Anime].self, from: data)
                print(animes)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    animes.forEach { anime in
                        self.animeLabel.text? += anime.russian + "\n\n"
                    }
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }
}

