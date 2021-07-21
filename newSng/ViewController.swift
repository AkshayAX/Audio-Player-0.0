//
//  ViewController.swift
//  newSng
//
//  Created by Akshaya Kumar N on 10/13/19.
//  Copyright © 2019 Akshaya Kumar N. All rights reserved.
//




import UIKit
import AVKit

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var shub: UIButton!
    
    @IBOutlet weak var slide: UISlider!
    @IBOutlet weak var img: UIImageView!
    
    var player:AVAudioPlayer!
    var array = [URL]()
    var count = 0
    var imgarr = ["s1","s2","s3","s4","s6","s7","s5"]
    var durations = 0.0
    var shuffle = false
    var s = 1
    var p = 1
    var temp = 0
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tap(tapped:)))
        self.slide.addGestureRecognizer(gesture)
        
        parse()
        
        do{
            try   player =  AVAudioPlayer(contentsOf: array[count])
            player.delegate = self
            print(count)
            print(array[count])
            
            
            
        }
        catch{
            print(error)
        }
        
        
        slide.value = 0.0
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func parse()
    {
        
        
        let urls = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "da.bundle")
        if let url = urls
        {
            for i in 0..<url.count
            {
                array.append(url[i])
            }
        }
        
        print(array)
        
    }
    
    
    
    
    @IBAction func play(_ sender: UIButton) {
        
        
        intel()
        
        
        if player.isPlaying
        {
            
            
            player.pause()
            
            print("paused")
            durations = player.currentTime
            print(player.currentTime)
        }
        else
        {
            
            if s == 0
            {
                img.image = UIImage(named: imgarr[temp])
                player.play()
                
                
            }
            else
            {
                slide.maximumValue = Float(player.duration)
                endTime()
                var timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
                
                
                print(count)
                print(array[count])
                player.stop()
                img.image = UIImage(named: imgarr[count])
                
                player.play()
            }
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        count = count + 1
        
        if  count == array.count
        {
            count = 0
        }
        
        if s == 0
        {
            shuff()
        }
        
        else
        
        {
            intel()
        }
        
        
    }
    
    
    
    @IBAction func next(_ sender: Any) {
        
        if s == 0
        {
            shuff()
            print("s = 0")
        }
        
        else
        
        {
            intel()
            
        }
        
        audioPlayerDidFinishPlaying(player, successfully: true)
        
        
    }
    
    
    
    
    @IBAction func back(_ sender: Any) {
        
        
        if s == 0
        {
            shuff()
            print("s = 0")
        }
        else
        {
            do{
                if  count == 1
                {
                    count =  array.count - 1 //before it was in 0 when back pressed count increased by 1.it is supposed to be 6
                }
                
                else if count == 0
                {
                    count =  array.count - 2
                    
                }
                
                else
                {
                    count = count - 2
                    
                }
                
                try   player = AVAudioPlayer(contentsOf: array[count])
                slide.maximumValue = Float(player.duration)
                currentTime.text = String(Float(player.duration))
                
                player.delegate = self
                img.image = UIImage(named: imgarr[count ])
                print(count)
                print(array[count])
                
                player.play()
                audioPlayerDidFinishPlaying(player, successfully: true)
                
                
            }
            catch{
                print(error)
            }
        }
        
    }
    
    
    @IBAction func slide(_ sender: UISlider) {
        
        player.stop()
        player.currentTime = TimeInterval(slide.value)
        player.prepareToPlay()
        player.play()
        
        
    }
    
    
    
    
    @IBAction func shuffle(_ sender: UIButton)
    {
        self.shuffle = !self.shuffle
        if shuffle
        {
            
            
            
            s = 0
            p = 1
            shuff()
            
        }
        else
        {
            s = 1
            
        }
        audioPlayerDidFinishPlaying(player, successfully: true)
        
    }
    
    
    @objc func updateSlider()
    {
        
        slide.value = Float(player.currentTime)
        let currentTime = Int(player.currentTime)
        let minutes = currentTime/60
        let mins = String(minutes)
        let seconds = currentTime - minutes * 60
        let secs = String(seconds)
        
        startTime.text = mins + ":" + secs
        
        
    }
    
    
    
    func shuff()
    {
        let arc = Int.random(in: 0...array.count - 1)
        temp = arc
        do   {
            player.stop()
            
            try     player = AVAudioPlayer(contentsOf: array[arc])
            print("value =")
            print(arc)
            img.image = UIImage(named: imgarr[arc])
            slide.maximumValue = Float(player.duration)
            endTime()
            
            player.play()
            
            player.delegate = self
            
            print(array[count])
            print(count)
            print(array.count - 1)
        }
        
        catch{
            print(error)
            
            
        }
        
        
    }
    
    
    
    
    
    func intel()
    {
        do{
            player.stop()
            
            try   player = AVAudioPlayer(contentsOf: array[count])
            // print("value =")
            // print(arc)
            img.image = UIImage(named: imgarr[count])
            slide.maximumValue = Float(player.duration)
            endTime()
            
            player.play()
            
            player.delegate = self
            
            print(array[count])
            print(count)
            print(array.count - 1)
        }
        
        catch{
            print(error)
            
            
            
        }
        
    }
    
    
    
    
    
    
    
    @objc func tap(tapped:UITapGestureRecognizer)
    {
        let pointTapped: CGPoint = tapped.location(in: self.view)
        
        let positionOfSlider: CGPoint = slide.frame.origin
        let widthOfSlider: CGFloat = slide.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(slide.maximumValue) / widthOfSlider)
        
        player.stop()
        player.currentTime = TimeInterval(newValue)
        player.prepareToPlay()
        player.play()
        
        
        
    }
    
    func endTime()
    {
        let endTime = Int(player.duration)
        let minutes = endTime/60
        let mins = String(minutes)
        let seconds = endTime - minutes * 60
        let secs = String(seconds)
        
        currentTime.text = mins + ":" + secs
        print(secs)
    }
    
    
    
    
    
}









