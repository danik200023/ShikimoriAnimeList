// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AnimeSearchQuery: GraphQLQuery {
  public static let operationName: String = "AnimeSearch"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AnimeSearch($name: String) { animes(limit: 50, search: $name) { __typename poster { __typename mainUrl } id name russian episodes episodesAired status } }"#
    ))

  public var name: GraphQLNullable<String>

  public init(name: GraphQLNullable<String>) {
    self.name = name
  }

  public var __variables: Variables? { ["name": name] }

  public struct Data: ShikimoriAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("animes", [Anime].self, arguments: [
        "limit": 50,
        "search": .variable("name")
      ]),
    ] }

    public var animes: [Anime] { __data["animes"] }

    /// Anime
    ///
    /// Parent Type: `Anime`
    public struct Anime: ShikimoriAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.Anime }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("poster", Poster?.self),
        .field("id", ShikimoriAPI.ID.self),
        .field("name", String.self),
        .field("russian", String?.self),
        .field("episodes", Int.self),
        .field("episodesAired", Int.self),
        .field("status", GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>?.self),
      ] }

      public var poster: Poster? { __data["poster"] }
      public var id: ShikimoriAPI.ID { __data["id"] }
      public var name: String { __data["name"] }
      public var russian: String? { __data["russian"] }
      public var episodes: Int { __data["episodes"] }
      public var episodesAired: Int { __data["episodesAired"] }
      public var status: GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>? { __data["status"] }

      /// Anime.Poster
      ///
      /// Parent Type: `Poster`
      public struct Poster: ShikimoriAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.Poster }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("mainUrl", String.self),
        ] }

        public var mainUrl: String { __data["mainUrl"] }
      }
    }
  }
}
