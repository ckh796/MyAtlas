//
//  CountryRowView.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 31/07/2025.
//


import SwiftUI
import SDWebImageSwiftUI


struct CountryRowView: View {
    let country: Country
    let onAdd: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            WebImage(url: URL(string: country.flag))
                .resizable()
                .frame(width: 32, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 4))

            Text(country.name)
                .foregroundColor(.primary)
                .lineLimit(1)

            Spacer()

            Button(action: onAdd) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 4)
        .background(Color.clear)
    }
}
