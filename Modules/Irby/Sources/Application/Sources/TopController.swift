//
//  TopController.swift
//  Irby
//
//  Created by John Smith on 04.12.16.
//  Copyright © 2016 Vladimir Semakov. All rights reserved.
//

import IrbyCoreEntities
import IrbyCoreNet
import NetworkingApiRest
import SwiftCommonsExtensions
import SwiftCommonsLang
import UIKit

//------------------------------------------------------------------

class TopController: UIViewController
{
// MARK: - Properties
    
     var songs = [String]()
    
// MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customTag = Roxie.newTag(for: type(of: self))

        if self.songs.isEmpty {
            self.songs = [Commons.SkilletBackFromDead, Commons.TheBeatlesYellowSubmarine]
        }

        translation(forArtist: "Rammstein", title: "Sonne")
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? SongController, let cell = sender as? UITableViewCell
        {
            let number = self.songs.index(of: (cell.textLabel?.text)!)!
            vc.setTitleString((cell.textLabel?.text)!)
        }
    }

// MARK: - Private Methods

    private func translation(forArtist: String, title: String) {

        weak var weakSelf = self

        // Perform request
        let entity = BasicRequestEntityBuilder<VoidBody>()
            .url(EndpointManager.defaultManager.baseURL)
            //.headers(DefaultHttpHeaders.headers())
            //.body(VendorJsonBody(body: body))
            .build()

        let callback = BasicRestApiCallback<VoidBody, [TextElementModel]>()
        callback.then(
            onSuccess: { call, entity, callback in
                callback(call, entity)


        },
            onFailure: { call, error, callback in
                callback(call, error)

                print(error)

//                // Show alert
//                AlertViewManager.showErrorAlertView(error)
        })

        let task = AmalgamaSongTaskBuilder()
            .tag(self.customTag!)
            .title(title)
            .artist(forArtist)
            //.httpClientConfig(ApplicationHttpClientConfig.SharedConfig)
            .requestEntity(entity)
            .build()

        TaskQueue.enqueue(task, callback: callback, callbackOnUiThread: true)
    }

// MARK: - Variables
            
    var customTag: String?
    
}

//------------------------------------------------------------------

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
