//
//  ViewController.swift
//  KingFaisalPrice
//
//  Created by Apple on 12/13/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import SwiftyGif
import MOLH

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var imagefile: UIImageView!
    
    @IBOutlet weak var languageButton: UIButton!
    
    var picker1Data: [String] = [String]()
    
    var picker2Data = Array<choiceItem>()
    
    var selected:Int?
    
    var winnersOn: Bool?
    
    var aboutOn: Bool?
    
    var ln = Ln()
    @IBOutlet weak var buttonEnter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = ln.title
        
        buttonEnter.setTitle(ln.enter, for: .normal)
        languageButton.setTitle(ln.language, for: .normal)
        
        picker1Data = [ln.introductionWord,ln.angayza,ln.categories,ln.nomination,ln.winners,ln.contactus]
        
        picker2Data.append(choiceItem(name: ln.khaledword, link: ln.khaledlink, video: "", certif: "", file: ""))
        
        do{
            let gif = try UIImage(gifName: "logoprize.gif")
            self.imagefile.setGifImage(gif, manager: SwiftyGifManager.defaultManager, loopCount: 10)
        }catch{
            print("asfa")
        }
        
        selected = 0
        winnersOn = false
    }
    @IBAction func changeLanguage(_ sender: Any) {
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        
        if #available(iOS 13.0, *) {
                let delegate = UIApplication.shared.delegate as? AppDelegate
                delegate!.swichRoot()
        } else {
               // Fallback on earlier versions
               MOLH.reset()
        }
    }

    
    
    @IBAction func nextButton(_ sender: Any) {
        
        
        if(winnersOn!)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "SelectWinnersViewController") as! SelectWinnersViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else
        {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            
            if(aboutOn!)
            {
                vc.link = ln.contactusLink
            }else
            {
                let ass = picker2Data[selected!].link
                print(ass!)
                vc.link = ass
            }
            
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    @IBAction func facebook(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://www.facebook.com/KingFaisalPrize/"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func twitter(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://twitter.com/KingFaisalPrize"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func instagram(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://www.instagram.com/kingfaisalprize/"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func youtube(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://www.youtube.com/user/KFIP1"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func linkedin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = "https://www.linkedin.com/company/king-faisal-international-prize"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func share(_ sender: Any) {
        
        // text to share
               let text = "https://www.facebook.com/KingFaisalPrize/"

               // set up activity view controller
               let textToShare = [ text ]
               let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

               // present the view controller
               self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = UILabel()
        
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Helvetica Neue", size: 15)
        
        if(pickerView == picker1)
        {
            label.text =  picker1Data[row]
        }else
        {
            label.text =  picker2Data[row].name
        }
        
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == picker1)
        {
            return picker1Data[row]
        }else
        {
            return picker2Data[row].name
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView == picker1)
        {
            return picker1Data.count
        }else
        {
            return picker2Data.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView == picker1)
        {
            selected = 0
            picker2Data.removeAll()
            if(row == 0)
            {
                picker2.isHidden = false
                winnersOn = false
                aboutOn = false
                picker2Data.append(choiceItem(name: ln.khaledword, link: ln.khaledlink, video: "", certif: "", file: ""))

            }else if(row == 1)
            {
                picker2.isHidden = false
                winnersOn = false
                aboutOn = false
                
                picker2Data.append(choiceItem(name: ln.nabza, link: ln.nabzaLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.enshaa, link: ln.enshaaLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.ahdaf, link: ln.ahdafLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.amana, link: ln.amanaLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.tare5, link: ln.tare5Link, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.mokawnat, link: ln.mokawnatLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.hay2a, link: ln.hay2aLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.mas2olen, link: ln.mas2olenLink, video: "", certif: "", file: ""))
                
            
            }else if(row == 2)
            {
                picker2.isHidden = false
                winnersOn = false
                aboutOn = false
                
                picker2Data.append(choiceItem(name: ln.eslam, link: ln.eslamLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.studies, link: ln.studiesLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.arabic, link: ln.arabicLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.medical, link: ln.medicalLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.science, link: ln.scienceLink, video: "", certif: "", file: ""))
               
            }
            else if(row == 3)
            {
                picker2.isHidden = false
                winnersOn = false
                aboutOn = false
                picker2Data.append(choiceItem(name: ln.eslam, link: ln.eslamNominationLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.studies, link: ln.studiesNominationLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.arabic, link: ln.arabicNominationLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.medical, link: ln.medicalNominationLink, video: "", certif: "", file: ""))
                picker2Data.append(choiceItem(name: ln.science, link: ln.scienceNominationLink, video: "", certif: "", file: ""))
                 
            }else if(row == 4)
            {
                picker2.isHidden = true
                winnersOn = true
                aboutOn = false
            }else if(row == 5)
            {
                picker2.isHidden = true
                winnersOn = false
                aboutOn = true
            }
            
            picker2.reloadAllComponents()
        }else
        {
            selected = row
        }
    }
    
}
