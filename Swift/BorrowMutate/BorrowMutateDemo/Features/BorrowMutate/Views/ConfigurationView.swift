//
//  ConfigurationView.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import SwiftUI

struct ConfigurationView: View {

    @Binding var selection: Int
    let sizes: [Int]

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            Picker(
                "Data Size",
                selection: $selection
            ) {

                ForEach(sizes, id: \.self) { size in
                    Text(size.formatted())
                        .tag(size)
                }
            }
            .pickerStyle(.segmented)

        }
    }
}
