//
//  CartViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 28/12/17.
//  Copyright © 2017 ANG RUI XIAN . All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cartDataClass = cartData.sharedInstance
    
    @IBOutlet weak var outTableViewCart: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.outTableViewCart.delegate = self as UITableViewDelegate
        self.outTableViewCart.dataSource = self as UITableViewDataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.outTableViewCart.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartDataClass.cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCart", for: indexPath) as! CartTableViewCell
        let row = indexPath.row
        func gradient(frame:CGRect) -> CAGradientLayer {
            let layer = CAGradientLayer()
            layer.frame = frame
            layer.startPoint = CGPoint(x:0.5,y:0.5)
            layer.endPoint = CGPoint(x:1.5,y:0.5)
            layer.colors = [
                UIColor.white.cgColor,UIColor.yellow.cgColor]
            return layer
        }
        //        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor.lightText.cgColor
        cell.layer.borderWidth = 5
        //Now on your tableViewcell do below
        cell.layer.insertSublayer(gradient(frame: cell.bounds), at:0)
        if let giftboxName = cell.outLabelGiftboxName {
            giftboxName.text = cartDataClass.cartArray[row].name
        }
        if let giftboxImage = cell.outImageViewGiftbox {
            giftboxImage.sd_setImage(with: Foundation.URL(string: cartDataClass.cartArray[row].thumbnail!))
        }
        if let giftboxPrice = cell.outLabelGiftboxPrice {
            giftboxPrice.text = "\(cartDataClass.cartArray[row].price!)0"
        }
        if let giftboxPackage = cell.outLabelGiftboxPackage {
            giftboxPackage.text = "E-voucher"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "showCartDetails", sender: self)
    }
    @IBAction func actButtonPayment(_ sender: UIButton) {
//        performSegue(withIdentifier: "proceedToOrderSummary", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
