//
//  CountryCacher.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 30/07/2025.
//
import CoreData

class CountryCacher {
    
    static let shared = CountryCacher()
    private let context = PersistenceController.shared.container.viewContext

    var countriesInMemory : [Country] = []
    private var countryForAlphaCode: [String:Country] = [:]
    
    
    func saveCountries(countries: [Country]) {

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CountryEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to delete existing countries: \(error)")
        }


        for country in countries {
            let entity = CountryEntity(context: context)
            entity.name = country.name
            entity.capital = country.capital
            entity.alpha2code = country.alpha2Code
            entity.flag = country.flag

            if let currency = country.currencies?.first {
                entity.currencyName = currency.name
                entity.currencyCode = currency.code
                entity.currencySymbol = currency.symbol
            }
        }

        do {
            try context.save()
        } catch {
            print("Failed to save countries: \(error)")
        }
    }

    func loadCountries(completion: @escaping ([Country]) -> Void) {
        context.perform {
            let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

            do {
                let results = try self.context.fetch(fetchRequest)
                let countries = results.map {
                    Country(
                        name: $0.name ?? "",
                        capital: $0.capital,
                        alpha2Code: $0.alpha2code ?? "",
                        flag: $0.flag ?? "",
                        currencies: [Currency(
                            code: $0.currencyCode,
                            name: $0.currencyName,
                            symbol: $0.currencySymbol
                        )]
                    )
                }
                self.countriesInMemory = countries
                
                self.buildCountryMap()
                
                completion(countries)
            } catch {
                print("Fetch error: \(error)")
                completion([])
            }
        }
    }
    
    func buildCountryMap() {
        for country in countriesInMemory {
            self.countryForAlphaCode[country.alpha2Code] = country
        }
    }

    
    func getCountryForCode(alpha2code: String) -> Country? {
        return countryForAlphaCode[alpha2code]
    }

    
}
