//
//  YHVideoPlayer.swift
//  YHNews
//
//  Created by yh on 2018/3/27.
//  Copyright © 2018年 YH. All rights reserved.
//

import UIKit

import AVKit

class YHVideoPlayer: UIView, NibLoadable {
    
    @IBOutlet private weak var playBtn: UIButton!
    @IBOutlet private weak var currentLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    
    private var url: String?
    private var Item: AVPlayerItem?
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    public func playVideo(urlString: String) {
        url = urlString
        
        Item = AVPlayerItem(url: URL(string: url!)!)
        
        if player == nil {
            createPlayer()
        } else {
            player?.replaceCurrentItem(with: Item)
        }
        Item?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playDidFinished(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: Item)
    }
    
    @IBAction func playClicked(_ sender: UIButton) {
        if sender.isSelected {
            player?.pause()
        } else {
            player?.play()
        }
    }
    
    @objc func playDidFinished(notification: Notification) {
        self.removeFromSuperview()
    }
    
    override func removeFromSuperview() {
        NotificationCenter.default.removeObserver(self)
        super.removeFromSuperview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            //取出status的新值
            let status: AVPlayerItemStatus = AVPlayerItemStatus(rawValue: change![NSKeyValueChangeKey.newKey] as! Int)!
            switch status {
            case .failed:
                print("item failed")
            case .readyToPlay:
                player?.play()
                let duration = CMTimeGetSeconds(Item!.duration)
                let minute = Int(duration) / 60
                let second = Int(duration) % 60
                self.totalLabel.text = String.init(format: "%02d : %02d", minute,second)
            case .unknown:
                print("视频资源出现未知错误")
            }
            Item?.removeObserver(self, forKeyPath: "status")
        } else if keyPath == "timeControlStatus" {
            let status: AVPlayerTimeControlStatus = AVPlayerTimeControlStatus(rawValue: change![NSKeyValueChangeKey.newKey] as! Int)!
            switch status {
            case .paused:
                playBtn.isSelected = false
            case .playing:
                playBtn.isSelected = true
            case .waitingToPlayAtSpecifiedRate:
                break
            }
        }
    }
    
    
    override func awakeFromNib() {
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 200)
    }
    
    func createPlayer() {
        player = AVPlayer(playerItem: Item)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.bounds
        layer.insertSublayer(playerLayer!, at: 0)
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main, using: { (time: CMTime) in
            let current = CMTimeGetSeconds(time)
            let minute = Int(current) / 60
            let second = Int(current) % 60
            self.currentLabel.text = String.init(format: "%02d : %02d", minute,second)
            
            let duration = CMTimeGetSeconds(self.Item!.duration)
            self.progressView.progress = Float(current/duration)
        })
        
        player?.addObserver(self, forKeyPath: "timeControlStatus", options: .new, context: nil)
    }

}
