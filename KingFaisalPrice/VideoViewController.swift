//
//  VideoViewController.swift
//  KingFaisalPrice
//
//  Created by Apple on 1/17/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Player

class VideoViewController: UIViewController {
    
    var video:String?
    
    @IBOutlet weak var videoview: UIView!
    
    
    fileprivate var player = Player()
    
    // MARK: object lifecycle
    deinit {
        self.player.willMove(toParent: nil)
        self.player.view.removeFromSuperview()
        self.player.removeFromParent()
    }
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        video = "https://www.kingfaisalappstore.org/" + video!
        
        print(video!)
       
        self.player.playerDelegate = self
        self.player.playbackDelegate = self
        
        self.player.playerView.playerBackgroundColor = .black
        
        self.addChild(self.player)
        
        let f = player.view.frame; //Grab current
        player.view.frame = CGRect(x: f.origin.x, y: f.origin.y, width: f.width, height: 200);
        
        self.videoview.addSubview(self.player.view)
        
        self.player.didMove(toParent: self)
        
        self.player.fillMode = .resizeAspect
        
        self.player.playbackEdgeTriggered = true
        
        //self.player.url = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        self.player.url = URL(string: video!)
        
        self.player.playbackLoops = true
        
        self.player.playFromBeginning()
    }


}


// MARK: - PlayerDelegate
extension VideoViewController: PlayerDelegate {
    
    func playerReady(_ player: Player) {
        print("\(#function) ready")
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        print("\(#function) \(player.playbackState.description)")
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        print("\(#function) error.description")
    }
    
}

// MARK: - PlayerPlaybackDelegate
extension VideoViewController: PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
    }
    
    func playerPlaybackDidLoop(_ player: Player) {
    }
}
