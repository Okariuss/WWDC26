//
//  BenchmarkActionButton.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import SwiftUI

struct BenchmarkActionButton: View {

    let isRunning: Bool
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            Label(
                isRunning
                ? "Running..."
                : "Run Benchmark",
                systemImage:
                    isRunning
                    ? "hourglass"
                    : "play.fill"
            )
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .disabled(isRunning)
    }
}
