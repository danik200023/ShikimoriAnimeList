// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AnimeDetailsQuery: GraphQLQuery {
  public static let operationName: String = "AnimeDetails"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AnimeDetails($ids: String) { animes(ids: $ids) { __typename description duration english episodes episodesAired id kind licenseNameRu name nextEpisodeAt rating russian score season status airedOn { __typename date } poster { __typename mainUrl } releasedOn { __typename date } userRate { __typename episodes id rewatches status anime { __typename english episodesAired episodes id russian score season status airedOn { __typename year } kind poster { __typename mainUrl } name } score } } }"#
    ))

  public var ids: GraphQLNullable<String>

  public init(ids: GraphQLNullable<String>) {
    self.ids = ids
  }

  public var __variables: Variables? { ["ids": ids] }

  public struct Data: ShikimoriAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("animes", [Anime].self, arguments: ["ids": .variable("ids")]),
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
        .field("description", String?.self),
        .field("duration", Int?.self),
        .field("english", String?.self),
        .field("episodes", Int.self),
        .field("episodesAired", Int.self),
        .field("id", ShikimoriAPI.ID.self),
        .field("kind", GraphQLEnum<ShikimoriAPI.AnimeKindEnum>?.self),
        .field("licenseNameRu", String?.self),
        .field("name", String.self),
        .field("nextEpisodeAt", ShikimoriAPI.ISO8601DateTime?.self),
        .field("rating", GraphQLEnum<ShikimoriAPI.AnimeRatingEnum>?.self),
        .field("russian", String?.self),
        .field("score", Double?.self),
        .field("season", String?.self),
        .field("status", GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>?.self),
        .field("airedOn", AiredOn?.self),
        .field("poster", Poster?.self),
        .field("releasedOn", ReleasedOn?.self),
        .field("userRate", UserRate?.self),
      ] }

      public var description: String? { __data["description"] }
      public var duration: Int? { __data["duration"] }
      public var english: String? { __data["english"] }
      public var episodes: Int { __data["episodes"] }
      public var episodesAired: Int { __data["episodesAired"] }
      public var id: ShikimoriAPI.ID { __data["id"] }
      public var kind: GraphQLEnum<ShikimoriAPI.AnimeKindEnum>? { __data["kind"] }
      public var licenseNameRu: String? { __data["licenseNameRu"] }
      public var name: String { __data["name"] }
      public var nextEpisodeAt: ShikimoriAPI.ISO8601DateTime? { __data["nextEpisodeAt"] }
      public var rating: GraphQLEnum<ShikimoriAPI.AnimeRatingEnum>? { __data["rating"] }
      public var russian: String? { __data["russian"] }
      public var score: Double? { __data["score"] }
      public var season: String? { __data["season"] }
      public var status: GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>? { __data["status"] }
      public var airedOn: AiredOn? { __data["airedOn"] }
      public var poster: Poster? { __data["poster"] }
      public var releasedOn: ReleasedOn? { __data["releasedOn"] }
      public var userRate: UserRate? { __data["userRate"] }

      /// Anime.AiredOn
      ///
      /// Parent Type: `IncompleteDate`
      public struct AiredOn: ShikimoriAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.IncompleteDate }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("date", ShikimoriAPI.ISO8601Date?.self),
        ] }

        public var date: ShikimoriAPI.ISO8601Date? { __data["date"] }
      }

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

      /// Anime.ReleasedOn
      ///
      /// Parent Type: `IncompleteDate`
      public struct ReleasedOn: ShikimoriAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.IncompleteDate }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("date", ShikimoriAPI.ISO8601Date?.self),
        ] }

        public var date: ShikimoriAPI.ISO8601Date? { __data["date"] }
      }

      /// Anime.UserRate
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

        /// Anime.UserRate.Anime
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

          /// Anime.UserRate.Anime.AiredOn
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

          /// Anime.UserRate.Anime.Poster
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
}
