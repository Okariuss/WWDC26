//
//  HeroCard.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import SwiftUI

struct HeroCard: View {

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text("Ownership Performance")
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text(
                "Measure the performance impact of borrowing and mutation on large audio buffers."
            )
            .foregroundStyle(.secondary)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(28)
        .glassEffect()
    }
}
