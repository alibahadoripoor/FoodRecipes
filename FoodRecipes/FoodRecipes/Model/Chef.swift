//
//  Chef.swift
//  FoodRecipes
//
//  Created by Mohammadali Bahadoripoor on 20.07.21.
//

import Foundation
import Contentful

final class Chef: EntryDecodable, FieldKeysQueryable {

    static let contentTypeId: String = "chef"

    let id: String
    let localeCode: String?
    let updatedAt: Date?
    let createdAt: Date?

    let name: String?

    public required init(from decoder: Decoder) throws {
        let sys = try decoder.sys()

        id = sys.id
        localeCode = sys.locale
        updatedAt = sys.updatedAt
        createdAt = sys.createdAt

        let fields = try decoder.contentfulFieldsContainer(keyedBy: Chef.FieldKeys.self)

        self.name = try fields.decodeIfPresent(String.self, forKey: .name)
    }

    enum FieldKeys: String, CodingKey {
        case name
    }
}
