//
//  NewAudioEngine.swift
//  MyApp
//
//  Created by Okan Orkun on 11.06.2026.
//

import Foundation

struct NewAudioEngine {
    private var _buffer: AudioBuffer
    
    init(size: Int) {
        _buffer = AudioBuffer(samples: Array(repeating: 0.0, count: size))
    }
    
    var buffer: AudioBuffer {
        borrow { _buffer }
        mutate { &_buffer }
    }
}
