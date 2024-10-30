// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AnimePostersQuery: GraphQLQuery {
  public static let operationName: String = "AnimePosters"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AnimePosters($ids: String) { animes(ids: $ids, limit: 50) { __typename poster { __typename mainUrl } id } }"#
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
      .field("animes", [Anime].self, arguments: [
        "ids": .variable("ids"),
        "limit": 50
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
      ] }

      public var poster: Poster? { __data["poster"] }
      public var id: ShikimoriAPI.ID { __data["id"] }

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
