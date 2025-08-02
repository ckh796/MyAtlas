//
//  MockCountryServiceFailure.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 31/07/2025.
//

import Combine
import Foundation


final class MockCountryServiceFailure: CountryService {
    
    override func fetchAllCountries() -> AnyPublisher<(progress: Double, countries: [Country]?), Error> {
        return Fail(error: URLError(.notConnectedToInternet))
            .eraseToAnyPublisher()
    }
    
}
