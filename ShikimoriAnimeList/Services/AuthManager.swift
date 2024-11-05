//
//  AuthManager.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 02.11.2024.
//

import Foundation
import AuthenticationServices

final class AuthManager: NSObject {
    static let shared = AuthManager()
    
    private override init() {}
    
    var isLoggedIn: Bool = false {
        didSet {
            NotificationCenter.default.post(name: .authStatusChanged, object: nil)
        }
    }
    
    func startAuthentication(completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://shikimori.one/oauth/authorize?client_id=wfUWoNxEIwfseLQ5vGJfQjeVOAAELibJw5zbOmCVnrc&redirect_uri=shikimoriapp%3A%2F%2Fcallback&response_type=code&scope=user_rates")!
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "shikimoriapp") { callbackURL, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let callbackURL, let queryItems = URLComponents(url: callbackURL, resolvingAgainstBaseURL: false)?.queryItems, let code = queryItems.first(where: { $0.name == "code" })?.value else {
                completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No code found in URL"])))
                return
            }
            UserDefaults.standard.setValue(code, forKey: "authCode")
            NetworkManager.shared.getAccessToken { [unowned self] result in
                switch result {
                case .success(_):
                    isLoggedIn = true
                case .failure(let error):
                    print(error)
                }
            }
            completion(.success(code))
        }
        
        session.presentationContextProvider = self
        session.start()
    }
}

//MARK: - ASWebAuthenticationPresentationContextProviding
extension AuthManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

extension Notification.Name {
    static let authStatusChanged = Notification.Name("authStatusChanged")
}
