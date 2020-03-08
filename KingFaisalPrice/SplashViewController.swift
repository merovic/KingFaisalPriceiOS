//
//  SplashViewController.swift
//  KingFaisalPrice
//
//  Created by Apple on 1/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import SwiftyGif

class SplashViewController: UIViewController {

    @IBOutlet weak var imagefile: UIImageView!
    
    var gameTimer: Timer! //Timer object
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let gif = try UIImage(gifName: "prizenew.gif")
            self.imagefile.setGifImage(gif, manager: SwiftyGifManager.defaultManager, loopCount: 10)
        }catch{
            print("asfa")
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(timeaction), userInfo: nil, repeats: true)


    }
    
    //Timer action
    @objc func timeaction(){
        
        //code for move next VC
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let secondViewController = storyboard.instantiateViewController(withIdentifier: "NaviViewController") as! NaviViewController
                   secondViewController.modalTransitionStyle = .crossDissolve
                   secondViewController.modalPresentationStyle = .fullScreen
                   if #available(iOS 13.0, *) {
                       secondViewController.isModalInPresentation = false
                   } else {
                       // Fallback on earlier versions
                   }
                   self.present(secondViewController, animated: true, completion: nil)
                   gameTimer.invalidate()//after that timer invalid
        
    }
    


}
