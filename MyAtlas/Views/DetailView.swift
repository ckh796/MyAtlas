//
//  DetailView.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 31/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    let country: Country

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemGroupedBackground),
                    Color("PrimaryColor")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                WebImage(url: URL(string: country.flag))
                    .resizable()
                    .aspectRatio(4/2.7, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 0))

                VStack(spacing: 12) {
                    if let capital = country.capital {
                        VStack {
                            Text("capital_city".localized)
                                .fontWeight(.semibold)
                            Text(capital)
                        }
                    }

                    if let currency = country.currencies?.first {
                        VStack {
                            Text("currency".localized)
                                .fontWeight(.semibold)
                            Text("\(currency.name ?? "") (\(currency.code ?? ""))")
                        }
                    }
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.top, 20)

                Spacer()
            }
        }
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
        .tint(Color("PrimaryColor"))
    }
}
