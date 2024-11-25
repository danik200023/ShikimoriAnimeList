// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UserRatesQuery: GraphQLQuery {
  public static let operationName: String = "UserRates"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query UserRates($page: PositiveInt) { userRates(targetType: Anime, limit: 50, page: $page) { __typename episodes id rewatches status anime { __typename english episodesAired episodes id russian score season status airedOn { __typename year } kind poster { __typename mainUrl } name } score } }"#
    ))

  public var page: GraphQLNullable<PositiveInt>

  public init(page: GraphQLNullable<PositiveInt>) {
    self.page = page
  }

  public var __variables: Variables? { ["page": page] }

  public struct Data: ShikimoriAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("userRates", [UserRate].self, arguments: [
        "targetType": "Anime",
        "limit": 50,
        "page": .variable("page")
      ]),
    ] }

    public var userRates: [UserRate] { __data["userRates"] }

    /// UserRate
    ///
    /// Parent Type: `UserRate`
    public struct UserRate: ShikimoriAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.UserRate }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("episodes", Int.self),
        .field("id", ShikimoriAPI.ID.self),
        .field("rewatches", Int.self),
        .field("status", GraphQLEnum<ShikimoriAPI.UserRateStatusEnum>.self),
        .field("anime", Anime?.self),
        .field("score", Int.self),
      ] }

      public var episodes: Int { __data["episodes"] }
      public var id: ShikimoriAPI.ID { __data["id"] }
      public var rewatches: Int { __data["rewatches"] }
      public var status: GraphQLEnum<ShikimoriAPI.UserRateStatusEnum> { __data["status"] }
      public var anime: Anime? { __data["anime"] }
      public var score: Int { __data["score"] }

      /// UserRate.Anime
      ///
      /// Parent Type: `Anime`
      public struct Anime: ShikimoriAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.Anime }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("english", String?.self),
          .field("episodesAired", Int.self),
          .field("episodes", Int.self),
          .field("id", ShikimoriAPI.ID.self),
          .field("russian", String?.self),
          .field("score", Double?.self),
          .field("season", String?.self),
          .field("status", GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>?.self),
          .field("airedOn", AiredOn?.self),
          .field("kind", GraphQLEnum<ShikimoriAPI.AnimeKindEnum>?.self),
          .field("poster", Poster?.self),
          .field("name", String.self),
        ] }

        public var english: String? { __data["english"] }
        public var episodesAired: Int { __data["episodesAired"] }
        public var episodes: Int { __data["episodes"] }
        public var id: ShikimoriAPI.ID { __data["id"] }
        public var russian: String? { __data["russian"] }
        public var score: Double? { __data["score"] }
        public var season: String? { __data["season"] }
        public var status: GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>? { __data["status"] }
        public var airedOn: AiredOn? { __data["airedOn"] }
        public var kind: GraphQLEnum<ShikimoriAPI.AnimeKindEnum>? { __data["kind"] }
        public var poster: Poster? { __data["poster"] }
        public var name: String { __data["name"] }

        /// UserRate.Anime.AiredOn
        ///
        /// Parent Type: `IncompleteDate`
        public struct AiredOn: ShikimoriAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.IncompleteDate }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("year", Int?.self),
          ] }

          public var year: Int? { __data["year"] }
        }

        /// UserRate.Anime.Poster
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
}
