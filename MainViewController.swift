//
//  MainViewController.swift
//  KalemProject
//
//  Created by Dzaki Izza on 29/04/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var natureTableView: UITableView!
    
    @IBOutlet weak var natureCollectionView: UICollectionView!
    
     var natureData = [Nature]()
            
    var recentlyAdded = [String]()
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        //layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 30
        self.natureCollectionView.showsHorizontalScrollIndicator = false
        
        self.natureCollectionView.collectionViewLayout = layout
        
        layout.itemSize = CGSize(width: 194, height: 178)
        natureCollectionView.collectionViewLayout = layout
        
        natureTableView.dataSource = self
        natureTableView.delegate = self
        
        natureCollectionView.delegate = self
        natureCollectionView.dataSource = self
        
        natureTableView.showsVerticalScrollIndicator = false
        
        //natureCollectionView.register(NatureCVC.nib(), forCellWithReuseIdentifier: "NatureCVC")
        
        configureNatureSound()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.backBarButtonItem?.tintColor = .white
        
        navigationController?.navigationBar.isHidden = false

        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let data = UserDefaults.standard.array(forKey: "added") as? [String] {
            recentlyAdded = data
        }
        natureCollectionView.reloadData()
        
    }
    
    
    func configureNatureSound() {
        
        natureData.append(Nature(naturesName: "Midnight Forest", naturesImage: "0", naturesSound: "Forest", natureDesc: "Relax with the calming sounds of a mountain river, gently trickling  through a colorful autumn forest."))
        natureData.append(Nature(naturesName: "Calm River", naturesImage: "1", naturesSound: "Forest Midnight", natureDesc: "Relax with sounds of tropical birdsong and buzzing cicadas and rest your eyes with the sights of lush tropical vegetation in the jungle. "))
        natureData.append(Nature(naturesName: "The Ocean Dream", naturesImage: "2", naturesSound: "Ocean Dream", natureDesc: "A wonderful experience of sleeping beside the ocean with waves rolling next to your bed."))
        natureData.append(Nature(naturesName: "Long Road", naturesImage: "3", naturesSound: "Countryside", natureDesc: "The sounds of a car driving on a long car ride on across countryside can be deeply soothing. "))
        natureData.append(Nature(naturesName: "A Little town", naturesImage: "4", naturesSound: "Calm Town", natureDesc: "A sound of calm town all you need to do is colse your eyes, relaxing and let the sound drive your sleep."))

    }
    

}

extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = natureTableView.dequeueReusableCell(withIdentifier: "cell") as! NatureTVC
        let natures = natureData[indexPath.row]
        
        cell.natureImageView.image = UIImage(named: natures.image)
                
        cell.natureImageView.image = cell.natureImageView.image?.roundedImage
        
        cell.natureImageView.clipsToBounds = true
        
        cell.natureLabel.text = natures.name
        
        cell.accessoryView?.backgroundColor = .white
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return natureData.count
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        

        
        if let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            let natures = natureData[indexPath.row]
            vc.natureImage = UIImage(named: natures.image)!
            vc.natureName = natures.name
            vc.descOfNature = natures.desc
            vc.sound = natures.soundOfNature
            vc.selectedIndex = indexPath.row
            
            
            self.navigationController?.pushViewController(vc, animated: true)


            

        }
    
        
        
    }

}
extension MainViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        natureCollectionView.deselectItem(at: indexPath, animated: true )
        
        if let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            let indexNature = Int(recentlyAdded[indexPath.row])


            vc.natureImage = UIImage(named: recentlyAdded[indexPath.row])!
            vc.natureName = natureData[indexNature!].name
            vc.descOfNature = natureData[indexNature!].desc
            vc.sound = natureData[indexNature!].soundOfNature
            vc.selectedIndex = indexNature!
            
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
    

}
extension MainViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentlyAdded.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = natureCollectionView.dequeueReusableCell(withReuseIdentifier: "NatureCVC", for: indexPath) as! NatureCVC
        let indexNature = Int(recentlyAdded[indexPath.row])

        cell.natureImageViews.image = UIImage(named: recentlyAdded[indexPath.row])
        cell.labelCollection.text = natureData[indexNature!].name
        
        cell.natureImageViews.image = cell.natureImageViews.image?.roundedImage
        cell.natureImageViews.clipsToBounds = true
        
                
        return cell
    }
}
    

extension MainViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 194, height: 178)
    }

 }




