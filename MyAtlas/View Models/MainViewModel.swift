//
//  MainViewModel.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 31/07/2025.
//

import Foundation

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    @Published var isShowingSearch = false
    @Published var selectedCountry: Country?
    @Published var favoriteCountries: [Country] = []
    @Published var showMaxAlert = false
    @Published var countryToRemove: Country?
    @Published var showRemoveAlert = false

    func openSearch() {
        let codes = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
        if codes.count >= 5 {
            showMaxAlert = true
        } else {
            isShowingSearch = true
        }
    }

    func closeSearch() {
        isShowingSearch = false
    }

    func loadFavorites() {
        let codes = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
        favoriteCountries = codes.compactMap {
            CountryCacher.shared.getCountryForCode(alpha2code: $0)
        }
    }
    
    func removeFromFavorites(_ country: Country) {
        var codes = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
        codes.removeAll { $0 == country.alpha2Code }
        UserDefaults.standard.setValue(codes, forKey: "favorites")
        loadFavorites()
    }
    
    func promptRemove(_ country: Country) {
        countryToRemove = country
        showRemoveAlert = true
    }
}
