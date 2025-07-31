//
//  SearchView.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 31/07/2025.
//


import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SearchViewModel()

     @Binding var selectedCountry: Country?

    var body: some View {
        ZStack {
            // Dark blurred background
            VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header with aligned dash and X button
                HStack(alignment: .center) {
                    Spacer()
                    Capsule()
                        .fill(Color.white.opacity(0.4))
                        .frame(width: 40, height: 5)
                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                            .padding(.vertical, 12)
                    }
                }
                .background(Color.clear)
                .padding(.top, 10)

                // Search bar
                TextField("search_countries_note".localized, text: $viewModel.query)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    .onChange(of: viewModel.query) {
                        viewModel.search()
                    }

                // Country list
                List {
                    ForEach(viewModel.filteredCountries, id: \.alpha2Code) { country in
                        Button {
                            var favorites = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
                            if !favorites.contains(where: { $0 == country.alpha2Code }) {
                                favorites.append(country.alpha2Code)
                                UserDefaults.standard.set(favorites, forKey: "favorites")
                            }

                            selectedCountry = country
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                dismiss()
                            }
                        } label: {
                            CountryRowView(country: country) {
                                // Optional: ignore "plus" logic or reuse it
                            }
                        }
                        .buttonStyle(.automatic)
                    }
                }
                .listStyle(.plain)
                .background(Color.clear) 
            }
            .background(Color.clear)
        }
        .preferredColorScheme(.dark)
        .background(Color.clear)
    }
}
