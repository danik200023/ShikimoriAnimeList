// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == ShikimoriAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == ShikimoriAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == ShikimoriAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == ShikimoriAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Anime": return ShikimoriAPI.Objects.Anime
    case "CharacterRole": return ShikimoriAPI.Objects.CharacterRole
    case "Genre": return ShikimoriAPI.Objects.Genre
    case "IncompleteDate": return ShikimoriAPI.Objects.IncompleteDate
    case "PersonRole": return ShikimoriAPI.Objects.PersonRole
    case "Poster": return ShikimoriAPI.Objects.Poster
    case "Query": return ShikimoriAPI.Objects.Query
    case "Related": return ShikimoriAPI.Objects.Related
    case "UserRate": return ShikimoriAPI.Objects.UserRate
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
