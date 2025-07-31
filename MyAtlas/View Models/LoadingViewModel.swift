//
//  LoadingViewModel.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 30/07/2025.
//

import Foundation
import Combine

final class LoadingViewModel: ObservableObject {
    
    @Published var progress: Double = 0.0
    @Published var hideProgressBar: Bool = true
    @Published var isFinished: Bool = false
    @Published var countries: [Country] = []

    private let useCase: FetchCountriesUseCase
    private var cancellables = Set<AnyCancellable>()

    init(useCase: FetchCountriesUseCase) {
        self.useCase = useCase
        
        CountryCacher.shared.loadCountries { [weak self] countries in
            if countries.isEmpty {
                self?.startLoading()
            } else {
                self?.proceedToMainView()
            }
        }
    }

    private func startLoading() {
        hideProgressBar = false
        useCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] result in
                self?.progress = result.progress
                if let countries = result.countries {
                    self?.countries = countries
                    self?.progress = 1.0
                    CountryCacher.shared.saveCountries(countries: countries)
                    CountryCacher.shared.countriesInMemory = countries
                    CountryCacher.shared.buildCountryMap()
                    self?.proceedToMainView()
                }
            }
            .store(in: &cancellables)
    }
    
    
    private func proceedToMainView() {
        isFinished = true
    }
}
