//
//  BenchmarkViewModel.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import Foundation
import Observation

@Observable
@MainActor
final class BenchmarkViewModel {

    // MARK: - State
    var isRunning = false
    var progress: Double = 0.0
    var showResults = false

    // MARK: - Configuration
    let availableSizes: [Int] = [50_000, 100_000, 250_000, 500_000, 1_000_000]
    var selectedSize: Int = 100_000
    private let iterations = 3_000

    // MARK: - Read Results
    var readOldTime: Double = 0.0
    var readNewTime: Double = 0.0

    var readAcceleration: Double {
        guard readOldTime > 0, readNewTime > 0 else { return 0 }
        return readOldTime / readNewTime
    }

    // MARK: - Write Results
    var writeOldTime: Double = 0.0
    var writeNewTime: Double = 0.0

    var writeAcceleration: Double {
        guard writeOldTime > 0, writeNewTime > 0 else { return 0 }
        return writeOldTime / writeNewTime
    }

    // MARK: - Compiler Optimization Blocker
    private var blackHole: Float = 0.0

    // MARK: - Entry Point
    func startBenchmark() async {
        reset()
        let size = selectedSize
        let clock = ContinuousClock()

        // ── TEST 1: READ (get vs borrow) ──────────────────────────────
        let oldForRead = OldAudioEngine(size: size)
        await Task.yield()

        let readOld = clock.measure {
            for _ in 0..<iterations {
                if let last = oldForRead.buffer.samples.last {
                    blackHole += last
                }
            }
        }

        progress = 0.25
        await Task.yield()

        let newForRead = NewAudioEngine(size: size)
        let readNew = clock.measure {
            for _ in 0..<iterations {
                if let last = newForRead.buffer.samples.last {
                    blackHole += last
                }
            }
        }

        progress = 0.5
        await Task.yield()

        // ── TEST 2: WRITE (set vs mutate) ─────────────────────────────
        var oldForWrite = OldAudioEngine(size: size)
        let writeOld = clock.measure {
            for i in 0..<iterations {
                oldForWrite.buffer.samples[0] = Float(i)
            }
        }

        progress = 0.75
        await Task.yield()

        var newForWrite = NewAudioEngine(size: size)
        let writeNew = clock.measure {
            for i in 0..<iterations {
                newForWrite.buffer.samples[0] = Float(i)
            }
        }

        blackHole += oldForWrite.buffer.samples[0]
        blackHole += newForWrite.buffer.samples[0]

        finalize(
            readOld:  readOld  / .milliseconds(1),
            readNew:  readNew  / .milliseconds(1),
            writeOld: writeOld / .milliseconds(1),
            writeNew: writeNew / .milliseconds(1)
        )
    }

    // MARK: - Helpers
    private func reset() {
        isRunning = true
        showResults = false
        progress = 0.0
        readOldTime = 0; readNewTime = 0
        writeOldTime = 0; writeNewTime = 0
    }

    private func finalize(readOld: Double, readNew: Double,
                          writeOld: Double, writeNew: Double) {
        readOldTime  = readOld
        readNewTime  = readNew
        writeOldTime = writeOld
        writeNewTime = writeNew
        progress = 1.0
        isRunning = false
        showResults = true
    }
}
