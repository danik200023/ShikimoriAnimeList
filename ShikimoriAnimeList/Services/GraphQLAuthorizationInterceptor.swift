//
//  GraphQLAuthorizationInterceptor.swift
//  ShikimoriAnimeList
//
//  Created by Данила Умнов on 31.10.2024.
//

import Foundation
import Apollo
import ApolloAPI

final class GraphQLAuthorizationInterceptor: ApolloInterceptor {
    let id: String = UUID().uuidString
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, any Error>) -> Void
    ) where Operation : GraphQLOperation {
        if let token = UserDefaults.standard.getOAuthToken() {
            request.addHeader(name: "Authorization", value: "Bearer \(token.accessToken)")
        }
        
        chain.proceedAsync(
            request: request,
            response: response,
            interceptor: self,
            completion: completion
        )
    }
}

final class NetworkInterceptorProvider: DefaultInterceptorProvider {
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(GraphQLAuthorizationInterceptor(), at: 0)
        return interceptors
    }
    
}
