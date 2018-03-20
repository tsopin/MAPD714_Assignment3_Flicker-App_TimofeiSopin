//
//  DetailVCViewController.swift
//  Advanced iOS Development Flicker App
//
//  Created by Timofei Sopin on 2018-03-19.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var sentImage : NSURL!
    var sentId : String!
    var sentTitle : String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(sentId!)"
//        self.title =
        self.image.setImageFromURl(stringImageUrl: sentImage)
        self.label.text = sentId
        self.textView.text = sentTitle
        
//        image.image = UIImage(named: sentData)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
}
extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: NSURL){
        
       
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        
    }
    

}
