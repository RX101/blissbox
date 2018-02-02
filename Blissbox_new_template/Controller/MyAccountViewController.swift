//
//  MyAccountViewController.swift
//  Blissbox_new_template
//
//  Created by ANG RUI XIAN  on 28/12/17.
//  Copyright © 2017 ANG RUI XIAN . All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var outCollectionViewVoucher: UICollectionView!
   
    var arrayMyAccount : [String] = ["Login","My Giftbox","Activate Voucher","My Orders","Change Password","Add Payment Method"]

    @IBOutlet weak var outTableViewMyAccount: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        outTableViewMyAccount.delegate = self
        outTableViewMyAccount.dataSource = self
        outCollectionViewVoucher.delegate = self
        outCollectionViewVoucher.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMyAccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMyAccount", for: indexPath)
        cell.textLabel?.text = arrayMyAccount[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let selectedRow = arrayMyAccount[row]
        if(selectedRow == "Login"){
//           presentDetail(LoginViewController())
            performSegue(withIdentifier: "myAccountToLogin", sender: self)
//            arrayMyAccount.append("Logout")
//            arrayMyAccount.removeFirst()
//            tableView.reloadData()
        }else if (selectedRow == "Logout"){
            arrayMyAccount.insert("Login", at: 0)
            arrayMyAccount.removeLast()
            tableView.reloadData()
        }
    }
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        outTableViewMyAccount.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellVoucher", for: indexPath) as! VoucherCollectionViewCell
        let item = indexPath.item
        let row = indexPath.row
        cell.outLabelGiftboxName.text = "Enjoy Giftinggg"
        cell.outLabelGiftboxVoucherCode.text = "123344"
        cell.outLabelGiftboxVoucherPin.text = "123344"
        
        return cell
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
