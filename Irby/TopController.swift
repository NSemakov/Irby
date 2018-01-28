//
//  TopController.swift
//  Irby
//
//  Created by John Smith on 04.12.16.
//  Copyright © 2016 Vladimir Semakov. All rights reserved.
//

import UIKit

//------------------------------------------------------------------

class TopController: UIViewController
{
// MARK: - Properties
    
     var songs = [String]()
    
// Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.songs.isEmpty {
            self.songs = [Commons.SkilletBackFromDead, Commons.TheBeatlesYellowSubmarine]
        }
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? SongController, let cell = sender as? UITableViewCell
        {
            let number = self.songs.index(of: (cell.textLabel?.text)!)!
            vc.setTitleString((cell.textLabel?.text)!)
        }
    }
    
// MARK: - Variables
            
   // ...
    
}

extension TopController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//------------------------------------------------------------------

extension TopController: UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.songs.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.songs[indexPath.row]
        
        return cell
    }
    
}

//------------------------------------------------------------------
