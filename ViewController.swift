//
//  ViewController.swift
//  KalemProject
//
//  Created by Dzaki Izza on 29/04/21.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var desc : [String] = ["Kalem is an application that helps you to meditate by listening to nature sounds that can reduce stress and can calm the mind.", "Meditation through music and nature sounds, such as the wind, running water, leaves or birdsong can quickly relax you. When the mind becomes calmer, then you can fall asleep easily."]
    


    override func viewDidLayoutSubviews() {
           scrollWidth = scrollView.frame.size.width
           scrollHeight = scrollView.frame.size.height
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        
        
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        for index in 0..<desc.count {
            
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)
            
            let txt = UILabel(frame:CGRect(x: labelTitle.frame.minX + 28, y: self.view.center.y - 120, width: 300,height: 220))
            txt.textAlignment = .center
            txt.font = UIFont(name: "SF Pro-Light", size: 1.0)
            txt.font = UIFont.systemFont(ofSize: 21.0)
            txt.numberOfLines = 0
            txt.textColor = .white
            txt.text = desc[index]
            
            
            if index == 1 {

                let btn = UIButton(frame: CGRect(x: txt.frame.minX - 8, y: self.view.center.y + 170, width: 306, height: 54))
                btn.backgroundColor = UIColor(rgb: 0x0C2557)
                btn.setTitle("Start", for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
                btn.layer.cornerRadius = 20
                btn.isEnabled = true
                btn.isUserInteractionEnabled = true
                btn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
                slide.addSubview(btn)

            }

            slide.addSubview(txt)
            scrollView.addSubview(slide)
            


        }

                
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(desc.count) , height: scrollHeight)
        self.scrollView.contentSize.height = 1.0

        pageControl.numberOfPages = desc.count
        pageControl.currentPage = 0
        
        UserDefaults.standard.set(true, forKey: "seen")
    
    }
    
    @objc func didTapButton() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "nvc") as? UINavigationController {
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func pageChanged(_ sender: Any) {
           scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
       }

       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           setIndiactorForCurrentPage()
       }

       func setIndiactorForCurrentPage()  {
           let page = (scrollView?.contentOffset.x)!/scrollWidth
           pageControl?.currentPage = Int(page)
       }

    
    

}

