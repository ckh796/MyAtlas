//
//  FetchCountriesUseCase.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 30/07/2025.
//

import Combine

final class FetchCountriesUseCase {
    private let countryService: CountryService
    
    init(countryService: CountryService = CountryService()) {
        self.countryService = countryService
    }
    
    func execute() -> AnyPublisher<(progress: Double, countries: [Country]?), Error> {
        return countryService.fetchAllCountries()
    }
}
