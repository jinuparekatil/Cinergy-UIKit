//
//  LoginViewController.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    // MARK: - Properties

    private var cancellables: Set<AnyCancellable> = []
    var viewModel: InitialViewModel?

    // MARK: - Outlets

    @IBOutlet weak var textStackView: UIStackView!

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextWithLeadingIcon()
//        if youu use clousure
//        subscribeToDataPublisher()
    }

    // MARK: - UI Setup

    private func setupTextWithLeadingIcon() {
        addTextWithLeadingIcon(text: "Enjoy a free popcorn on sign up.")
        addTextWithLeadingIcon(text: "Enjoy a $5.00 Elite reward after 300 \n points to spend however you want.")
        addTextWithLeadingIcon(text: "Enjoy a special birthday movie \n ticket offer.")
        addTextWithLeadingIcon(text: "Enjoy exclusive content, sneak peaks,\n and special offers!.")
    }

    private func addTextWithLeadingIcon(text: String) {
        let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        starImageView.contentMode = .scaleAspectFit
        starImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true

        let textLabel = UILabel()
        textLabel.text = text
        textLabel.numberOfLines = 2
        textLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let horizontalStackView = UIStackView(arrangedSubviews: [starImageView, textLabel])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8

        textStackView.addArrangedSubview(horizontalStackView)
    }

    // MARK: - Data Subscription

    private func subscribeToDataPublisher() {
        viewModel?.didLogin.bindAndFire { [weak self] success in
            if success {
                self?.navigateToEscapeViewController()
            } else {
                print("Failed")
            }
        }
    }

    // MARK: - Actions

    @IBAction func guestButtonPressed(_ sender: Any) {
        viewModel?.fetchDataPublisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] _ in
                self?.navigateToEscapeViewController()
            })
            .store(in: &cancellables)

        viewModel?.fetchPosts()
    }

    // MARK: - Navigation

    private func navigateToEscapeViewController() {
        let escapeRoomViewModel = EscapeRoomViewModel()
        let router = Router()

        DispatchQueue.main.async {
            if let escapeRoomViewController = router.getEscapeViewController(withIdentifier: "EscapeRoomViewControllerId", viewModel: escapeRoomViewModel) {

                // Wrap EscapeRoomViewController in a UINavigationController
                let navigationController = UINavigationController(rootViewController: escapeRoomViewController)
                
                // Set the modal presentation style for the navigation controller
                navigationController.modalPresentationStyle = .fullScreen
                
                // Present the navigation controller modally
                self.present(navigationController, animated: false, completion: nil)
            }
        }
    }
}
