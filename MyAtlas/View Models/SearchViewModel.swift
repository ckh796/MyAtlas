//
//  SearchViewModel.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 31/07/2025.
//


import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var filteredCountries: [Country] = []

    private let allCountries: [Country]

    init() {
        // Load all countries once into memory
        self.allCountries = CountryCacher.shared.countriesInMemory
        self.filteredCountries = allCountries
    }

    func search() {
        if query.isEmpty {
            filteredCountries = allCountries
        } else {
            filteredCountries = allCountries.filter {
                $0.name.localizedCaseInsensitiveContains(query)
            }
        }
    }
}
