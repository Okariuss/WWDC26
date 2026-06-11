//
//  BenchmarkResultsView.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import SwiftUI

struct BenchmarkResultsView: View {

    let viewModel: BenchmarkViewModel

    var body: some View {
        VStack(spacing: 28) {
            
            // ─── TEST 1: READ PERFORMANCE ───
            VStack(alignment: .leading, spacing: 12) {
                Text("Read Test (get vs borrow)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Grid(alignment: .leading, verticalSpacing: 14) {
                    GridRow {
                        Text("get Accessor (Old)")
                        Spacer()
                        Text(formatTime(viewModel.readOldTime))
                            .monospacedDigit()
                            .foregroundStyle(viewModel.readNewTime > viewModel.readOldTime ? .green : .primary)

                    }

                    Divider()

                    GridRow {
                        Text("borrow Accessor (New)")
                        Spacer()
                        Text(formatTime(viewModel.readNewTime))
                            .monospacedDigit()
                            .fontWeight(.medium)
                            .foregroundStyle(viewModel.readNewTime < viewModel.readOldTime ? .green : .primary)
                    }
                    
                    if viewModel.readAcceleration > 0 {
                        Divider()
                        GridRow {
                            Text("Read Gain")
                                .foregroundStyle(.blue)
                            Spacer()
                            Text("\(viewModel.readAcceleration.formatted(.number.precision(.fractionLength(2))))x faster")
                                .monospacedDigit()
                                .bold()
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding()
                .background(Color.primary.opacity(0.03))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // ─── TEST 2: WRITE PERFORMANCE ───
            VStack(alignment: .leading, spacing: 12) {
                Text("Write Test (set vs mutate)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Grid(alignment: .leading, verticalSpacing: 14) {
                    GridRow {
                        Text("set Accessor (Old)")
                        Spacer()
                        Text(formatTime(viewModel.writeOldTime))
                            .monospacedDigit()
                    }

                    Divider()

                    GridRow {
                        Text("mutate Accessor (New)")
                        Spacer()
                        Text(formatTime(viewModel.writeNewTime))
                            .monospacedDigit()
                            .fontWeight(.medium)
                            .foregroundStyle(viewModel.writeNewTime < viewModel.writeOldTime ? .green : .primary)
                    }
                    
                    if viewModel.writeAcceleration > 0 {
                        Divider()
                        GridRow {
                            Text("Write Gain")
                                .foregroundStyle(.blue)
                            Spacer()
                            Text("\(viewModel.writeAcceleration.formatted(.number.precision(.fractionLength(2))))x faster")
                                .monospacedDigit()
                                .bold()
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding()
                .background(Color.primary.opacity(0.03))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
    
    // MARK: - Helper Formatting
    private func formatTime(_ milliseconds: Double) -> String {
        guard milliseconds > 0 else { return "—" }
        return "\(milliseconds.formatted(.number.precision(.fractionLength(3)))) ms"
    }
}
