//
//  FavoriteCountryCell.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 31/07/2025.
//


import SwiftUI
import SDWebImageSwiftUI


struct FavoriteCountryCell: View {
    let country: Country
    let onLongPress: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            WebImage(url: URL(string: country.flag))
                .resizable()
                .aspectRatio(4/2.7, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(country.name)
                .font(.system(size: 16))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onLongPressGesture {
            onLongPress()
        }
    }
}
