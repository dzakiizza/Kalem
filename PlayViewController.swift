//
//  PlayViewController.swift
//  KalemProject
//
//  Created by Dzaki Izza on 30/04/21.
//

import UIKit
import AVFoundation
import AVKit

class PlayViewController: UIViewController {

     var position : Int = 0
    
    public var natureSound : [Nature] = []
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet var holder : UIView!
    @IBOutlet var label : UILabel!
    
    let playPauseButton = UIButton()
    let resetButton = UIButton()

    
    var player : AVAudioPlayer?
    var timeRemaining : Int = 0
    var timer : Timer!
    var resetTimeRemaining : Int = 0
    
    var titles = ""
    var desc = ""
    var soundNature = ""
    
    let ud = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        configureNatureSound()
        
        btn.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
    
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if holder.subviews.count == 0 {
            configure()
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)


            
        }
    }
    
    func configureNatureSound() {
        
        natureSound.append(Nature(naturesName: "Midnight Forest", naturesImage: "0", naturesSound: "Forest", natureDesc: "Relax with the calming sounds of a mountain river, gently trickling  through a colorful autumn forest."))
        natureSound.append(Nature(naturesName: "Calm River", naturesImage: "1", naturesSound: "Forest Midnight", natureDesc: "Relax with sounds of tropical birdsong and buzzing cicadas and rest your eyes with the sights of lush tropical vegetation in the jungle. "))
        natureSound.append(Nature(naturesName: "The Ocean Dream", naturesImage: "2", naturesSound: "Ocean Dream", natureDesc: "A wonderful experience of sleeping beside the ocean with waves rolling next to your bed."))
        natureSound.append(Nature(naturesName: "Long Road", naturesImage: "3", naturesSound: "Countryside", natureDesc: "The sounds of a car driving on a long car ride on across countryside can be deeply soothing. "))
        natureSound.append(Nature(naturesName: "A calm town", naturesImage: "4", naturesSound: "Calm Town", natureDesc: "A sound of calm town all you need to do is colse your eyes, relaxing and let the sound drive your sleep."))

    }
    
    @IBAction func btnExit(_ sender: Any) {
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .clear
            var recentlyPlayed = [String]()
                        
            if let savedRecent = UserDefaults.standard.array(forKey: "added") as? [String] {
                recentlyPlayed = savedRecent
            }
            
            if recentlyPlayed.contains(String(position)) == false {
                
                recentlyPlayed.insert(String(position), at: 0)

            }
            else if recentlyPlayed.contains(String(position)) == true{
                
                let indexRecent = recentlyPlayed.firstIndex(of: String(position))


                recentlyPlayed.remove(at: indexRecent!)

                recentlyPlayed.insert(String(position), at: 0)

                
            }
            
            UserDefaults.standard.setValue(recentlyPlayed, forKey: "added")

            
            self.navigationController?.popViewController(animated: true)

        
    }

    func configure() {
        
        let songs = natureSound[position]
        
        let urlString = Bundle.main.path(forResource: songs.soundOfNature , ofType: "mp3")
        

        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = player else {
                return
            }
            
            player.play()
            
            player.numberOfLoops = -1
            

        } catch  {
            print("error")
        }
        
        
        //Frame
        playPauseButton.frame = CGRect(x: label.frame.minX + 145, y: self.view.center.y - 25, width: 80.0, height: 80.0)
    
        resetButton.frame = CGRect(x: label.frame.minX + 145, y: self.view.center.y + 65, width: 80.0, height: 80.0)

        
        //Add Actions
        playPauseButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)

        
        //Styling
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
        resetButton.setBackgroundImage(UIImage(systemName: "gobackward"), for: .normal)

        playPauseButton.tintColor = .white
        resetButton.tintColor = .white
        
        resetButton.isHidden = true
        
        view.addSubview(playPauseButton)
        view.addSubview(resetButton)
        
    }
    
    @objc func resetButtonTapped() {
        
        timeRemaining = resetTimeRemaining
        player?.play()
        playPauseButton.isEnabled = true
        resetButton.isHidden = true
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)

    }
    
    @objc func didTapButton() {
        
        if player?.isPlaying == true {
            player?.pause()
            timer.invalidate()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)

            

        }else {
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)


        }
        
    }
    
    @objc func step() {
        var hours: Int
         var minutes: Int
         var seconds: Int

         if timeRemaining == 1 {
            player?.stop()
            timer?.invalidate()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            playPauseButton.isEnabled = false
            resetButton.isHidden = false


         }
         timeRemaining -= 1
         hours = timeRemaining / 3600
         minutes = (timeRemaining % 3600) / 60
         seconds = (timeRemaining % 3600) % 60
         label.text = String(format: "%02d : %02d : %02d", hours, minutes, seconds)
        label.textColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let player = player {
            player.stop()
        }
    }
  }
    

