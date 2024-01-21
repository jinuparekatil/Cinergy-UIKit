//
//  DetailViewController.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 21/01/2024.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var upToNummberOfMembersLabel: UILabel!
    @IBOutlet weak var detailText: UITextView!

    // MARK: - Properties
    
    var movie: EscapeRoom?

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrangeView()
    }

    // MARK: - UI Setup
    
    private func arrangeView() {
        setupLabels()
        setupImageView()
    }

    private func setupLabels() {
        titleText.text = movie?.title
        runTimeLabel.text = "\(movie?.runTime ?? "0") mins"
        detailText.text = movie?.synopsis
    }

    private func setupImageView() {
        // Safely set the image only if the URL is valid
        if let url = URL(string: movie?.imageUrl ?? "") {
            imageView.sd_setImage(with: url, completed: nil)
        }
    }

    // MARK: - Actions
    
    @IBAction func bookNowButtonPressed(_ sender: Any) {
        // Handle book now button press
    }

    @IBAction func moreInfoButtonPressed(_ sender: Any) {
        // Handle more info button press
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        // Handle close button press
        self.dismiss(animated: true)
    }
}
