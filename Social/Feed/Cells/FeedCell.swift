//
//  FeedCell.swift
//  Social
//
//  Created by John Crossley on 11/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    private var viewModel: FeedItemViewModel?

    private let generator = UIImpactFeedbackGenerator(style: .light)

    @IBOutlet private var heartButton: UIButton!
    @IBOutlet private var bodyTextView: UITextView!
    @IBOutlet private var likeCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        bodyTextView.textContainer.lineFragmentPadding = 0
        bodyTextView.textContainerInset = .zero

        heartButton.imageView?.contentMode = .scaleAspectFit

        backgroundColor = UIColor(named: "primaryColor")
    }

    func bind(to viewModel: FeedItemViewModel) {
        self.viewModel = viewModel

        bodyTextView.text = viewModel.post
        likeCountLabel.text = "\(viewModel.numberOfLikes)"

        if viewModel.isLiked {
            setHeart(to: .full)
        } else {
            setHeart(to: .empty)
        }
    }

    enum Heart: String {
        case full = "heart_filled"
        case empty = "heart"
    }

    private func setHeart(to heart: Heart) {
        heartButton.setImage(UIImage(named: heart.rawValue), for: .normal)
    }

    @IBAction func didTapHeart(sender: UIButton) {
        guard let viewModel = self.viewModel else { return }

        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn], animations: {
            self.heartButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            self.generator.impactOccurred()
        }, completion: { hasComplete in
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.heartButton.transform = .identity
                self?.setHeart(to: viewModel.isLiked ? .empty : .full)
            })
        })
    }
}
