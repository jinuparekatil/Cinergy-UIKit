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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var upToNummberOfMembersLabel: UILabel!
    @IBOutlet weak var detailText: UITextView!

    @IBOutlet weak var bookNowButton: UIButton!
    // MARK: - Properties
    var viewModel: DetailMovieViewModel?
    var  movie: MovieInfo?

//    var movie: EscapeRoom?

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupViews()
    }
   
    // MARK: - UI Setup
    
    private func arrangeView() {
//            setupLabels()
//            setupImageView()
    }
    private func setupViews(){
        if let viewModel = self.viewModel {
            
            viewModel.isMovieDetailView.bindAndFire { [weak self] success in
                if success {
                    self?.movie = viewModel.movie?.movieInfo
                    self?.setupLabels()
                    self?.bookNowButton.isEnabled = true
                    self?.setupImageView()
                }
            }

            
        }
    }
    private func setupLabels() {
//        print(viewModel?.movie)
        titleLabel.text =  self.movie?.title
        runTimeLabel.text = "\(self.movie?.runTime ?? "0") mins"
        detailText.text = self.movie?.synopsis
    }

    private func setupImageView() {
        // Safely set the image only if the URL is valid
        if let url = URL(string: self.movie?.imageURL ?? "") {
            imageView.sd_setImage(with: url, completed: nil)
        }
    }

    // MARK: - Actions
    
    @IBAction func bookNowButtonPressed(_ sender: Any) {
   
        bookVieCotroller()
        
    }
    
    private func bookVieCotroller(){
        let bookMovieViewModel = MovieBookingViewModel(movie: (self.movie)!)
        let router = Router()

        DispatchQueue.main.async {
            if let detailMovieViewController = router.getMovieDetailsVCViewController(withIdentifier: "BookViewControllerId", viewModel: bookMovieViewModel) {
                
                detailMovieViewController.modalPresentationStyle = .fullScreen
                self.present(detailMovieViewController, animated: false, completion: nil)
            }
        }
    }

    @IBAction func moreInfoButtonPressed(_ sender: Any) {
        // Handle more info button press
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        // Handle close button press
        self.dismiss(animated: true)
    }
}
