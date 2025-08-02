//
//  CountryServiceTests.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 02/08/2025.
//


import XCTest
import Combine


final class CountryServiceTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func test_fetchAllCountries_success() {
        let service = MockCountryServiceSuccess()
        let expectation = expectation(description: "Countries fetched successfully")

        service.fetchAllCountries()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, got error: \(error)")
                }
            }, receiveValue: { result in
                let countries = result.countries ?? []
                XCTAssertEqual(countries.count, 2)
                XCTAssertEqual(countries.first?.name, "France")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchAllCountries_failure() {
        let service = MockCountryServiceFailure()
        let expectation = expectation(description: "Countries fetch failed")

        service.fetchAllCountries()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is URLError)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no values")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
