//
//  SplashScreenViewController.swift
//  croins
//
//  Created by Daniella Onishi on 29/11/21.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var jacarias: UIImageView!
    @IBOutlet weak var coin1: UIImageView!
    @IBOutlet weak var coin2: UIImageView!
    @IBOutlet weak var coin3: UIImageView!
    @IBOutlet weak var blink1: UIImageView!
    @IBOutlet weak var blink2: UIImageView!
    @IBOutlet weak var blink3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat]) {
//            self.coin1.frame = CGRect(x: self.coin1.frame.origin.x, y: self.coin1.frame.origin.y + 20, width: self.coin1.frame.size.width, height: self.coin1.frame.size.height
//            )} completion: { _ in
//                UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
//                    self.coin1.frame = CGRect(x: self.coin1.frame.origin.x, y: self.coin1.frame.origin.y - 20, width: self.coin1.frame.size.width, height: self.coin1.frame.size.height
//                    )}
//            }
//    }
}
