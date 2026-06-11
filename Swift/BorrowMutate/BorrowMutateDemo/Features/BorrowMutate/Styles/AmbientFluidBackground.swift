//
//  AmbientFluidBackground.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import SwiftUI

struct AmbientBackground: View {
    var body: some View {
        Color(.windowBackgroundColor)
            .overlay {
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        [0,0], [0.5,0], [1,0],
                        [0,0.5], [0.5,0.5], [1,0.5],
                        [0,1], [0.5,1], [1,1]
                    ],
                    colors: [
                        .blue.opacity(0.15),
                        .clear,
                        .indigo.opacity(0.1),

                        .clear,
                        .clear,
                        .clear,

                        .purple.opacity(0.08),
                        .clear,
                        .clear
                    ]
                )
                .blur(radius: 80)
            }
            .ignoresSafeArea()
    }
}
