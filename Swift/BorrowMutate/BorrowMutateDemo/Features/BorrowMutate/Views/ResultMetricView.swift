//
//  ResultMetricView.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import SwiftUI

struct ResultMetricView: View {

    let multiplier: Double

    var body: some View {

        VStack(spacing: 4) {

            Text(
                String(format: "%.1f×", multiplier)
            )
            .font(.system(size: 92, weight: .bold))
            .contentTransition(.numericText())

            Text("Performance Gain")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
