//
//  RootView.swift
//  MyAtlas
//
//  Created by Charbel Khalifeh Hachem on 31/07/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = LoadingViewModel(useCase: FetchCountriesUseCase())

    var body: some View {
        if viewModel.isFinished {
            NavigationStack {
                MainView()
            }
        } else {
            LoadingView(viewModel: viewModel)
        }
    }
}
