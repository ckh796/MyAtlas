//
//  DummyCountries.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 02/08/2025.
//


import Foundation

enum DummyCountries {
    static let all: [Country] = [
        Country(name: "France", capital: "Paris", alpha2Code: "FR", flag: "https://flagcdn.com/fr.svg", currencies: [
            Currency(code: "EUR", name: "Euro", symbol: "€")
        ]),
        Country(name: "Japan", capital: "Tokyo", alpha2Code: "JP", flag: "https://flagcdn.com/jp.svg", currencies: [
            Currency(code: "JPY", name: "Yen", symbol: "¥")
        ])
    ]
}
