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
    @Published var isLoadingInitialCountry = false
    private var didCheckLocation = false

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
        let newFavorites = codes.compactMap {
            CountryCacher.shared.getCountryForCode(alpha2code: $0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.favoriteCountries = newFavorites
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
    

    func requestInitialCountryIfNeeded() {
        var favorites = UserDefaults.standard.stringArray(forKey: "favorites") ?? []

        // Don't do anything if already checked or favorites already exist
        guard !didCheckLocation, favorites.isEmpty else { return }

        DispatchQueue.main.async {
            self.isLoadingInitialCountry = true
        }

        LocationManager.shared.requestCountry { placemark in
            let alpha2Code = placemark?.isoCountryCode ?? Locale.current.region?.identifier

            DispatchQueue.main.async {
                guard let code = alpha2Code else {
                    self.isLoadingInitialCountry = false
                    self.didCheckLocation = true
                    return
                }

                if !favorites.contains(code),
                   let _ = CountryCacher.shared.getCountryForCode(alpha2code: code),
                   favorites.count < 5 {
                    favorites.insert(code, at: 0)
                    UserDefaults.standard.setValue(favorites, forKey: "favorites")
                }

                self.loadFavorites()
                self.isLoadingInitialCountry = false
                self.didCheckLocation = true
            }
        }
    }
}
