//
//  FindOutController.swift
//  Irby
//
//  Created by John Smith on 14.12.16.
//  Copyright © 2016 Vladimir Semakov. All rights reserved.
//

import Foundation
import UIKit

class FindOutController: UIViewController
{
// MARK: - Init
    
    deinit {
        self.timer?.invalidate()
    }
    
// MARK: - Properties
    
    var songs = [String]()
    
    @IBOutlet private(set) weak var activityIndicator: UIActivityIndicatorView!
    
// MARK: - Actions
    
    @IBAction func touchFindOutSong(_ sender: Any) {
        self.activityIndicator.startAnimating()

        let timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { [weak self] timer in
            self?.activityIndicator.stopAnimating()
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SongController") as! SongController
            vc.setTitleString(Commons.SkilletBackFromDead)
            self?.navigationController?.show(vc, sender: nil)
        }
        self.timer = timer
    }
    
// Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
// MARK: - Variables
    
    var timer: Timer?
    

}
