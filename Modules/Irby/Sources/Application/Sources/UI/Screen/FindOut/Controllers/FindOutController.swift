//
//  FindOutController.swift
//  Irby
//
//  Created by John Smith on 14.12.16.
//  Copyright © 2016 Vladimir Semakov. All rights reserved.
//

//------------------------------------------------------------------

import Foundation
import IrbyCoreEntities
import IrbyCoreNet
import MediaPlayer
import NetworkingApiRest
import SwiftCommonsExtensions
import SwiftCommonsLang
import UIKit

//------------------------------------------------------------------

class FindOutController: UIViewController
{
// MARK: - Init
    
    deinit {
//        self.timer?.invalidate()
    }
    
// MARK: - Properties
    
    var songs = [String]()
    
    @IBOutlet private(set) weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet private(set) weak var tableView: UITableView!

// MARK: - Actions
    
    @IBAction func touchFindOutSong(_ sender: Any) {
        self.activityIndicator.startAnimating()

        let player = MPMusicPlayerController.systemMusicPlayer
        if let mediaItem = player.nowPlayingItem,
           let title = mediaItem.title,
           let artist = mediaItem.artist {

            translation(forArtist: artist, title: title)
        }
        else {
            AlertViewManager.showErrorAlertView("Cannot!", actionHandler: nil, cancelButtonTitle: nil)
        }
    }
    
// Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerCellClass(UnionStringCell.self)

        self.tableView.estimatedRowHeight = Inner.EstimatedRowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension

        self.customTag = Roxie.newTag(for: type(of: self))

        //translation(forArtist: "Rammstein", title: "Sonne")
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

                if let songElements = entity.body {
                    weakSelf?.songElements = songElements
                    weakSelf?.tableView.reloadData()
                }
        },
            onFailure: { call, error, callback in
                callback(call, error)

                print(error)

                //                // Show alert
                //                AlertViewManager.showErrorAlertView(error)
        })

        callback.thenUI(
            initInterface: { call, callback in
                // Nothing to do
        },
            finalize: { call, entity, callback in
                weakSelf?.activityIndicator.stopAnimating()
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

// MARK: - Constants

    fileprivate struct Inner
    {
        static let EstimatedRowHeight: CGFloat = 100.0 // 100 pt
    }

// MARK: - Variables
    
//    var timer: Timer?

    var customTag: String?

    var songElements = [TextElementModel]()

}

//------------------------------------------------------------------

extension FindOutController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//------------------------------------------------------------------

extension FindOutController: UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.songElements.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellOfClass(UnionStringCell.self, forIndexPath: indexPath)

        cell.updateView(self.songElements[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

//------------------------------------------------------------------
