//
//  MainView.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 31/07/2025.
//

import SwiftUI


struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            if !viewModel.favoriteCountries.isEmpty {
                
                Text("top_destinations".localized)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(viewModel.favoriteCountries, id: \.alpha2Code) { country in
                        NavigationLink {
                            DetailView(country: country)
                        } label: {
                            FavoriteCountryCell(
                                country: country,
                                onLongPress: {
                                    viewModel.promptRemove(country)
                                }
                            )
                        }
                        .buttonStyle(PlainButtonStyle()) // prevents default blue highlight
                    }
                }
                .padding(.horizontal, 20)
                
                Text("hold_to_remove".localized)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 12)
                
            } else {
                Text("no_destinations_yet".localized)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("TextLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .foregroundColor(Color("PrimaryColor"))
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.openSearch()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("PrimaryColor"))
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowingSearch, onDismiss: {
            viewModel.loadFavorites()
        }) {
            SearchView(selectedCountry: $viewModel.selectedCountry)
        }
        .onAppear {
            viewModel.loadFavorites()
        }
        .alert("max_dest_reached".localized, isPresented: $viewModel.showMaxAlert) {
            Button("ok".localized, role: .cancel) { }
        } message: {
            Text("max_dest_reached_note".localized)
        }
        .preferredColorScheme(.light)
        .alert("remove_destination".localized, isPresented: $viewModel.showRemoveAlert) {
            Button("delete".localized, role: .destructive) {
                if let country = viewModel.countryToRemove {
                    viewModel.removeFromFavorites(country)
                }
            }
            Button("cancel".localized, role: .cancel) {}
        } message: {
            Text("remove_dest_note".localized)
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
