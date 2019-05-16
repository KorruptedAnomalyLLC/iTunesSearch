//
//  iTunesItemTableViewCell.swift
//  iTunesApp
//
//  Created by Austin West on 5/16/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class iTunesItemTableViewCell: UITableViewCell {

    var iTunesResult: iTunesResults? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!

    func updateViews() {
        
        guard let iTunesResult = iTunesResult else { return }
        self.trackLabel.text = iTunesResult.track
        self.artistLabel.text = iTunesResult.artist
        self.albumLabel.text = iTunesResult.album
    }
}
