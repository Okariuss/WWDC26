//
//  OldAudioEngine.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import Foundation

struct OldAudioEngine {
    private var _buffer: AudioBuffer
    
    init(size: Int) {
        _buffer = AudioBuffer(samples: Array(repeating: 0.0, count: size))
    }
    
    var buffer: AudioBuffer {
        get { _buffer }
        set { _buffer = newValue }
    }
}
