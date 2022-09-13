//
//  Model.swift
//  PossumusChallenge
//
//  Created by Francisco Donadio on 13/09/2022.
//

import Foundation

struct AlbumModel: Codable {
    let data: [Albums]
}

struct Albums: Codable {
    var userId: Int!
    var id: Int!
    var title: String!
}
    
