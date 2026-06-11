//
//  BenchmarkView.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import SwiftUI

struct BenchmarkView: View {

    @State private var viewModel = BenchmarkViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                AmbientBackground()

                ScrollView {
                    VStack(spacing: 32) {
                        HeroCard()

                        Group {
                            if viewModel.showResults {
                                let maxAcceleration = max(viewModel.readAcceleration, viewModel.writeAcceleration)
                                
                                ResultMetricView(
                                    multiplier: maxAcceleration
                                )

                                BenchmarkResultsView(
                                    viewModel: viewModel
                                )

                            } else if viewModel.isRunning {
                                VStack(spacing: 16) {
                                    ProgressView()
                                        .controlSize(.large)

                                    Text("\(Int(viewModel.progress * 100))%")
                                        .font(.title2)
                                        .monospacedDigit()
                                }
                            } else {
                                ContentUnavailableView(
                                    "Ready",
                                    systemImage: "gauge.with.needle",
                                    description: Text(
                                        "Run the benchmark to compare ownership performance."
                                    )
                                )
                            }
                        }
                        .animation(.smooth, value: viewModel.showResults)

                        Divider()

                        ConfigurationView(
                            selection: $viewModel.selectedSize,
                            sizes: viewModel.availableSizes
                        )

                        BenchmarkActionButton(
                            isRunning: viewModel.isRunning
                        ) {
                            Task {
                                await viewModel.startBenchmark()
                            }
                        }
                    }
                    .padding(32)
                    .frame(maxWidth: 900)
                }
            }
            .navigationTitle("Benchmark")
        }
    }
}
