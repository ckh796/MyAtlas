//
//  Country.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 30/07/2025.
//

import Foundation

struct Country: Decodable {
    let name: String
    let capital: String?
    let alpha2Code: String
    let flag: String
    let currencies: [Currency]?
}

struct Currency: Decodable {
    let code: String?
    let name: String?
    let symbol: String?
}
