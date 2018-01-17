//
//  GiftboxDetailsViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 9/1/18.
//  Copyright © 2018 ANG RUI XIAN . All rights reserved.
//

import UIKit
import Cosmos
class GiftboxDetailsViewController: UIViewController {
    
    let fileAPI = apiFile.sharedInstance
    let index = apiFile.sharedInstance.row
    let giftboxDataClass = giftboxData.sharedInstance
    let cartDataClass = cartData.sharedInstance
    var boxRating : Int = 0
    //    var passedTitle : String = ""
    
    
    @IBOutlet weak var outImageViewGiftbox: UIImageView!
    @IBOutlet weak var outTextViewDescription: UITextView!
    @IBOutlet weak var outRatingBar: CosmosView!
    @IBOutlet weak var outLabelGiftboxPrice: UILabel!
    @IBOutlet weak var outButtonAddToCart: UIButton!
    @IBOutlet weak var outButtonExploreExperience: UIButton!
    
    @IBOutlet weak var outNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outButtonAddToCart.clipsToBounds = true
        self.outButtonAddToCart.layer.cornerRadius = 10
        self.outButtonExploreExperience.clipsToBounds = true
        self.outButtonExploreExperience.layer.cornerRadius = 10
        self.outRatingBar.rating = 0
        
        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
        outRatingBar.didFinishTouchingCosmos = { rating in
            self.boxRating = Int(self.outRatingBar.rating)
        }
        
        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        self.outRatingBar.didTouchCosmos = { rating in }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let selectedGiftbox = giftboxDataClass.get(index: index)
        self.outNavigationItem.title = "\(selectedGiftbox.name!)"
        self.outImageViewGiftbox.sd_setImage(with: Foundation.URL(string: selectedGiftbox.thumbnail!))
        self.outLabelGiftboxPrice.text = "\(selectedGiftbox.price!)0"
        self.outTextViewDescription.text = "\(selectedGiftbox.description!)"
        //        var boxRating : Double = Double(selectedGiftbox.review!)
        //        self.outRatingBar.rating = boxRating
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actButtonAddToCart(_ sender: UIButton) {
//        if let nc = self.navigationController {
//            // pop the current view controller off the navigation stack
//            nc.popViewController(animated: true)
//        }
        let selectedGiftbox = giftboxDataClass.get(index: index)
        let addToCart = cartData.init(name: selectedGiftbox.name!, price: selectedGiftbox.price!, thumbnail: selectedGiftbox.thumbnail!, description: selectedGiftbox.description!)
        cartDataClass.add(data: addToCart)
        print("Giftbox have been added.")
        
    }
    
    @IBAction func actButtonExploreExperience(_ sender: UIButton) {
        performSegue(withIdentifier: "giftboxDetailsToExperience", sender: self)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
