//
//  MockCountryServiceSuccess.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 02/08/2025.
//

import Combine


final class MockCountryServiceSuccess: CountryService {
    override func fetchAllCountries() -> AnyPublisher<(progress: Double, countries: [Country]?), Error> {
        return Just((progress: 1.0, countries: DummyCountries.all))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
