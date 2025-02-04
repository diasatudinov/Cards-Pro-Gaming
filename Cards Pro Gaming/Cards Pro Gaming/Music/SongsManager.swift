//
//  SongsManager.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 04.02.2025.
//


import AVFoundation

class SongsManager {
    static let shared = SongsManager()
    var audioPlayer: AVAudioPlayer?

    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "backgroundSong", withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 
            audioPlayer?.play()
        } catch {
            print("Could not play background music: \(error)")
        }
    }

    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}
