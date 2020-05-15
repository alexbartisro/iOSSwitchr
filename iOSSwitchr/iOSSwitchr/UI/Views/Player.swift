//
//  Player.swift
//  iOSSwitchr
//
//  Created by alexandru.bartis on 13/05/2020.
//  Copyright © 2020 Alex Bartis. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(frame: .zero)
    }}


class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    var player: AVPlayer!

    override init(frame: CGRect) {
        super.init(frame: frame)

        guard let path = Bundle.main.path(forResource: "tutorial", ofType:"mov") else {
             return
         }

        player = AVPlayer(url: URL(fileURLWithPath: path))
        player.play()

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }

        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
