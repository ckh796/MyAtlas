//
//  CountryService.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 30/07/2025.
//

import Foundation
import Combine

class CountryService: NSObject {
    private var session: URLSession!
    private var dataTask: URLSessionDataTask?
    private var receivedData = Data()
    private var expectedContentLength: Int64 = 0
    
    private let subject = PassthroughSubject<(progress: Double, countries: [Country]?), Error>()
    
    override init() {
        super.init()
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    func fetchAllCountries() -> AnyPublisher<(progress: Double, countries: [Country]?), Error> {
        guard let url = URL(string: Endpoints.FETCH_COUNTRIES_API) else {
            subject.send(completion: .failure(URLError(.badURL)))
            return subject.eraseToAnyPublisher()
        }
        
        dataTask = session.dataTask(with: url)
        dataTask?.resume()
        
        return subject.eraseToAnyPublisher()
    }
}

extension CountryService: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        expectedContentLength = response.expectedContentLength
        receivedData = Data()
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        receivedData.append(data)
        
        let progress = expectedContentLength > 0
            ? Double(receivedData.count) / Double(expectedContentLength)
            : 0
        
        subject.send((progress, nil))
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if let jsonString = String(data: receivedData, encoding: .utf8) {
            print("🌍 Raw response: \(jsonString)")
        }
        
        if let error = error {
            subject.send(completion: .failure(error))
            return
        }
        
        do {
            let countries = try JSONDecoder().decode([Country].self, from: receivedData)
            subject.send((1.0, countries))
            subject.send(completion: .finished)
        } catch {
            subject.send(completion: .failure(error))
        }
    }
}
