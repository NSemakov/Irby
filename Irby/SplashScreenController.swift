//
//  SplashScreenController.swift
//  Irby
//
//  Created by John Smith on 15.12.16.
//  Copyright © 2016 Vladimir Semakov. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] timer in
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
            self?.present(vc, animated: true, completion: nil)
        }
        self.timer = timer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private var timer: Timer?
}
