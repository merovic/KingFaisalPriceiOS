//
//  ImageViewController.swift
//  KingFaisalPrice
//
//  Created by Apple on 1/17/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import SDWebImage

class ImageViewController: UIViewController {

    
    @IBOutlet weak var imagefile: UIImageView!
    
    var image:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image = "https://www.kingfaisalappstore.org/" + image!
        
        print(image!)
        
        imagefile.sd_setImage(with: URL(string: image!), placeholderImage: UIImage(named: "logo2.png"))
        
    }
    
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
