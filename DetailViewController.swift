//
//  DetailViewController.swift
//  KalemProject
//
//  Created by Dzaki Izza on 30/04/21.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {

    @IBOutlet weak var natureImageView: UIImageView!
    @IBOutlet weak var natureLabel: UILabel!
    @IBOutlet weak var natureDesc: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    var duration = [("10 mins",600),
                    ("20 mins",1200),
                    ("30 mins",1800),
                    ("40 mins",2400),
                    ("50 mins",3000),
                    ("60 mins",3600),
                    ("70 mins",4200),
                    ("80 mins",4800),
                    ("90 mins",5400),
                    ("100 mins",6000)]
    
    var selectedCurrent = 600
        
    var natureName = ""
    var natureImage = UIImage()
    var descOfNature = ""
    var sound = ""
        
    var selectedIndex = 0
    
    var selectedIndexCol = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        
        natureLabel.text = natureName
        natureImageView.image = natureImage
        
        natureDesc.text = descOfNature
        natureImageView.image = natureImageView.image?.roundedImage
        
            
        playBtn.layer.cornerRadius = 20
        
        picker.delegate = self
        picker.dataSource = self
        
        
        self.navigationItem.backBarButtonItem?.tintColor = .white
        
        

    }
    

    
    
    @IBAction func playSound(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "PlayViewController") as? PlayViewController {
            
            

            vc.position = selectedIndex
            vc.timeRemaining = selectedCurrent
            vc.resetTimeRemaining = selectedCurrent
            vc.titles = natureName
            vc.desc = descOfNature
            vc.soundNature = sound
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
            navigationController?.navigationBar.isHidden = true


        }
                
    
    }

}
    


extension DetailViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return duration.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return duration[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrent = duration[row].1
    }
    
    
    
}
