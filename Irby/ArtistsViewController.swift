//
//  ArtistsViewController.swift
//  Irby
//
//  Created by John Smith on 15.12.16.
//  Copyright © 2016 Vladimir Semakov. All rights reserved.
//

import UIKit

class ArtistsViewController: UIViewController
{
// MARK: - Properties
    
    var artists = [String]()
    
// Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.artists = ["Skillet", "The Beatles"]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? TopController, let cell = sender as? UITableViewCell
        {
            let number = self.artists.index(of: (cell.textLabel?.text)!)!
            if number == 0 {
                vc.songs = [Commons.SkilletBackFromDead, Commons.SkilletRise]
            }
            else if number == 1 {
                vc.songs = [Commons.TheBeatlesYellowSubmarine, Commons.TheBeatlesYesterday]
            }
        }
    }
    
// MARK: - Variables
    
    // ...
    
}

extension ArtistsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//------------------------------------------------------------------

extension ArtistsViewController: UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.artists.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.artists[indexPath.row]
        
        return cell
    }
    
}

//------------------------------------------------------------------
