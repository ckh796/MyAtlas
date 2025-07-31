//
//  LoadingView.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 30/07/2025.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @ObservedObject var viewModel: LoadingViewModel

    var body: some View {
        ZStack {
            Color("PrimaryColor")
                .ignoresSafeArea()

            VStack {
                Spacer()
                
                Image("Splash")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(.horizontal, 60)

                Spacer()
                
                ProgressView(value: viewModel.progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .white))
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                    .opacity(viewModel.hideProgressBar ? 0 : 1)
            }
        }
    }
}

