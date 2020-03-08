//
//  WinnersListViewController.swift
//  KingFaisalPrice
//
//  Created by Apple on 12/14/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class WinnersListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var search:String?
    
    var items = Array<winnerItem>()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Winners()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WinnersTableViewCell") as! WinnersTableViewCell
        
            
        cell.winnerName.text = items[indexPath.row].name!
        cell.winnerType.text = items[indexPath.row].type!
        
        cell.winnerImage.sd_setImage(with: URL(string: "https://www.kingfaisalappstore.org/" + items[indexPath.row].image!), placeholderImage: UIImage(named: "logo1.png"))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.link = items[indexPath.row].link
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func Winners()
    {
        
        items.removeAll()
        
        AF.request("https://technowow.net/webservice_prize.asmx/select_all_prize_by_searchname", method: .get, parameters: [ "text_name": search ]).responseData { (dataResponse) in

            if let data = dataResponse.data {
                print(String(data: data, encoding: .utf8) ?? "")
                
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                    {
                        
                        let itemsArray : NSArray  = jsonArray as NSArray
                        
                        for i in 0..<itemsArray.count {
                            
                            self.items.append(winnerItem(name: ((itemsArray[i] as AnyObject).value(forKey: "name") as? String)!, link: ((itemsArray[i] as AnyObject).value(forKey: "url") as? String)!, type: ((itemsArray[i] as AnyObject).value(forKey: "type") as? String)!, image: ((itemsArray[i] as AnyObject).value(forKey: "img") as? String)!))
                        }
                    
                        self.tableView.reloadData()
                        
                    //    let id = String(((itemsArray[0] as AnyObject).value(forKey: "id") as! Int))
                        
                    //    let year = ((itemsArray[0] as AnyObject).value(forKey: "year") as? String)!
                        
                    //    let name = ((itemsArray[0] as AnyObject).value(forKey: "name") as? String)!
                        
                    //    let date_prize = ((itemsArray[0] as AnyObject).value(forKey: "date_prize") as? String)!
                        
                    //    let image = ((itemsArray[0] as AnyObject).value(forKey: "img") as? String)!
                        
                    //    let type = ((itemsArray[0] as AnyObject).value(forKey: "type") as? String)!
                        
                    //    let url = ((itemsArray[0] as AnyObject).value(forKey: "url") as? String)!
                    
            
                    } else {
                        print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
                
            }
        }
        
        
    }


}
