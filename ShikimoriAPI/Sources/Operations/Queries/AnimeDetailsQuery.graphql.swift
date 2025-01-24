// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AnimeDetailsQuery: GraphQLQuery {
  public static let operationName: String = "AnimeDetails"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AnimeDetails($ids: String) { animes(ids: $ids) { __typename createdAt description descriptionSource duration english episodes episodesAired franchise id japanese kind licenseNameRu licensors malId name nextEpisodeAt opengraphImageUrl rating russian score season status airedOn { __typename date day month year } characterRoles { __typename id rolesEn rolesRu } genres { __typename entryType id kind name russian } personRoles { __typename id rolesEn rolesRu } poster { __typename id main2xUrl mainAlt2xUrl mainAltUrl mainUrl mini2xUrl miniAlt2xUrl miniAltUrl miniUrl originalUrl preview2xUrl previewAlt2xUrl previewAltUrl previewUrl } related { __typename id relationEn relationKind relationRu relationText } releasedOn { __typename date day month year } userRate { __typename chapters createdAt episodes id rewatches score status text updatedAt volumes } } }"#
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
        .field("createdAt", ShikimoriAPI.ISO8601DateTime.self),
        .field("description", String?.self),
        .field("descriptionSource", String?.self),
        .field("duration", Int?.self),
        .field("english", String?.self),
        .field("episodes", Int.self),
        .field("episodesAired", Int.self),
        .field("franchise", String?.self),
        .field("id", ShikimoriAPI.ID.self),
        .field("japanese", String?.self),
        .field("kind", GraphQLEnum<ShikimoriAPI.AnimeKindEnum>?.self),
        .field("licenseNameRu", String?.self),
        .field("licensors", [String]?.self),
        .field("malId", ShikimoriAPI.ID?.self),
        .field("name", String.self),
        .field("nextEpisodeAt", ShikimoriAPI.ISO8601DateTime?.self),
        .field("opengraphImageUrl", String?.self),
        .field("rating", GraphQLEnum<ShikimoriAPI.AnimeRatingEnum>?.self),
        .field("russian", String?.self),
        .field("score", Double?.self),
        .field("season", String?.self),
        .field("status", GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>?.self),
        .field("airedOn", AiredOn?.self),
        .field("characterRoles", [CharacterRole]?.self),
        .field("genres", [Genre]?.self),
        .field("personRoles", [PersonRole]?.self),
        .field("poster", Poster?.self),
        .field("related", [Related]?.self),
        .field("releasedOn", ReleasedOn?.self),
        .field("userRate", UserRate?.self),
      ] }

      public var createdAt: ShikimoriAPI.ISO8601DateTime { __data["createdAt"] }
      public var description: String? { __data["description"] }
      public var descriptionSource: String? { __data["descriptionSource"] }
      public var duration: Int? { __data["duration"] }
      public var english: String? { __data["english"] }
      public var episodes: Int { __data["episodes"] }
      public var episodesAired: Int { __data["episodesAired"] }
      public var franchise: String? { __data["franchise"] }
      public var id: ShikimoriAPI.ID { __data["id"] }
      public var japanese: String? { __data["japanese"] }
      public var kind: GraphQLEnum<ShikimoriAPI.AnimeKindEnum>? { __data["kind"] }
      public var licenseNameRu: String? { __data["licenseNameRu"] }
      public var licensors: [String]? { __data["licensors"] }
      public var malId: ShikimoriAPI.ID? { __data["malId"] }
      public var name: String { __data["name"] }
      public var nextEpisodeAt: ShikimoriAPI.ISO8601DateTime? { __data["nextEpisodeAt"] }
      public var opengraphImageUrl: String? { __data["opengraphImageUrl"] }
      public var rating: GraphQLEnum<ShikimoriAPI.AnimeRatingEnum>? { __data["rating"] }
      public var russian: String? { __data["russian"] }
      public var score: Double? { __data["score"] }
      public var season: String? { __data["season"] }
      public var status: GraphQLEnum<ShikimoriAPI.AnimeStatusEnum>? { __data["status"] }
      public var airedOn: AiredOn? { __data["airedOn"] }
      public var characterRoles: [CharacterRole]? { __data["characterRoles"] }
      public var genres: [Genre]? { __data["genres"] }
      public var personRoles: [PersonRole]? { __data["personRoles"] }
      public var poster: Poster? { __data["poster"] }
      public var related: [Related]? { __data["related"] }
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
          .field("day", Int?.self),
          .field("month", Int?.self),
          .field("year", Int?.self),
        ] }

        public var date: ShikimoriAPI.ISO8601Date? { __data["date"] }
        public var day: Int? { __data["day"] }
        public var month: Int? { __data["month"] }
        public var year: Int? { __data["year"] }
      }

      /// Anime.CharacterRole
      ///
      /// Parent Type: `CharacterRole`
      public struct CharacterRole: ShikimoriAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.CharacterRole }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShikimoriAPI.ID.self),
          .field("rolesEn", [String].self),
          .field("rolesRu", [String].self),
        ] }

        public var id: ShikimoriAPI.ID { __data["id"] }
        public var rolesEn: [String] { __data["rolesEn"] }
        public var rolesRu: [String] { __data["rolesRu"] }
      }

      /// Anime.Genre
      ///
      /// Parent Type: `Genre`
      public struct Genre: ShikimoriAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.Genre }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("entryType", GraphQLEnum<ShikimoriAPI.GenreEntryTypeEnum>.self),
          .field("id", ShikimoriAPI.ID.self),
          .field("kind", GraphQLEnum<ShikimoriAPI.GenreKindEnum>.self),
          .field("name", String.self),
          .field("russian", String.self),
        ] }

        public var entryType: GraphQLEnum<ShikimoriAPI.GenreEntryTypeEnum> { __data["entryType"] }
        public var id: ShikimoriAPI.ID { __data["id"] }
        public var kind: GraphQLEnum<ShikimoriAPI.GenreKindEnum> { __data["kind"] }
        public var name: String { __data["name"] }
        public var russian: String { __data["russian"] }
      }

      /// Anime.PersonRole
      ///
      /// Parent Type: `PersonRole`
      public struct PersonRole: ShikimoriAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.PersonRole }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShikimoriAPI.ID.self),
          .field("rolesEn", [String].self),
          .field("rolesRu", [String].self),
        ] }

        public var id: ShikimoriAPI.ID { __data["id"] }
        public var rolesEn: [String] { __data["rolesEn"] }
        public var rolesRu: [String] { __data["rolesRu"] }
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
          .field("id", ShikimoriAPI.ID.self),
          .field("main2xUrl", String.self),
          .field("mainAlt2xUrl", String.self),
          .field("mainAltUrl", String.self),
          .field("mainUrl", String.self),
          .field("mini2xUrl", String.self),
          .field("miniAlt2xUrl", String.self),
          .field("miniAltUrl", String.self),
          .field("miniUrl", String.self),
          .field("originalUrl", String.self),
          .field("preview2xUrl", String.self),
          .field("previewAlt2xUrl", String.self),
          .field("previewAltUrl", String.self),
          .field("previewUrl", String.self),
        ] }

        public var id: ShikimoriAPI.ID { __data["id"] }
        public var main2xUrl: String { __data["main2xUrl"] }
        public var mainAlt2xUrl: String { __data["mainAlt2xUrl"] }
        public var mainAltUrl: String { __data["mainAltUrl"] }
        public var mainUrl: String { __data["mainUrl"] }
        public var mini2xUrl: String { __data["mini2xUrl"] }
        public var miniAlt2xUrl: String { __data["miniAlt2xUrl"] }
        public var miniAltUrl: String { __data["miniAltUrl"] }
        public var miniUrl: String { __data["miniUrl"] }
        public var originalUrl: String { __data["originalUrl"] }
        public var preview2xUrl: String { __data["preview2xUrl"] }
        public var previewAlt2xUrl: String { __data["previewAlt2xUrl"] }
        public var previewAltUrl: String { __data["previewAltUrl"] }
        public var previewUrl: String { __data["previewUrl"] }
      }

      /// Anime.Related
      ///
      /// Parent Type: `Related`
      public struct Related: ShikimoriAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { ShikimoriAPI.Objects.Related }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", ShikimoriAPI.ID.self),
          .field("relationEn", String.self),
          .field("relationKind", GraphQLEnum<ShikimoriAPI.RelationKindEnum>.self),
          .field("relationRu", String.self),
          .field("relationText", String.self),
        ] }

        public var id: ShikimoriAPI.ID { __data["id"] }
        @available(*, deprecated, message: "use relation_kind/relation_text instead. This field will be deleted after 2025-01-01")
        public var relationEn: String { __data["relationEn"] }
        public var relationKind: GraphQLEnum<ShikimoriAPI.RelationKindEnum> { __data["relationKind"] }
        @available(*, deprecated, message: "use relation_kind/relation_text instead. This field will be deleted after 2025-01-01")
        public var relationRu: String { __data["relationRu"] }
        public var relationText: String { __data["relationText"] }
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
          .field("day", Int?.self),
          .field("month", Int?.self),
          .field("year", Int?.self),
        ] }

        public var date: ShikimoriAPI.ISO8601Date? { __data["date"] }
        public var day: Int? { __data["day"] }
        public var month: Int? { __data["month"] }
        public var year: Int? { __data["year"] }
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
          .field("chapters", Int.self),
          .field("createdAt", ShikimoriAPI.ISO8601DateTime.self),
          .field("episodes", Int.self),
          .field("id", ShikimoriAPI.ID.self),
          .field("rewatches", Int.self),
          .field("score", Int.self),
          .field("status", GraphQLEnum<ShikimoriAPI.UserRateStatusEnum>.self),
          .field("text", String?.self),
          .field("updatedAt", ShikimoriAPI.ISO8601DateTime.self),
          .field("volumes", Int.self),
        ] }

        public var chapters: Int { __data["chapters"] }
        public var createdAt: ShikimoriAPI.ISO8601DateTime { __data["createdAt"] }
        public var episodes: Int { __data["episodes"] }
        public var id: ShikimoriAPI.ID { __data["id"] }
        public var rewatches: Int { __data["rewatches"] }
        public var score: Int { __data["score"] }
        public var status: GraphQLEnum<ShikimoriAPI.UserRateStatusEnum> { __data["status"] }
        public var text: String? { __data["text"] }
        public var updatedAt: ShikimoriAPI.ISO8601DateTime { __data["updatedAt"] }
        public var volumes: Int { __data["volumes"] }
      }
    }
  }
}
