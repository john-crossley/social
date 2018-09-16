//
//  FeedCell.swift
//  Social
//
//  Created by John Crossley on 11/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

protocol FeedCellDelegate: class {
    func didTapOptions(for itemId: String)
}

class FeedCell: UICollectionViewCell {
    weak var delegate: FeedCellDelegate?

    private var viewModel: FeedItemViewModel?

    private let generator = UIImpactFeedbackGenerator(style: .light)

//    @IBOutlet private var heartButton: UIButton!
    @IBOutlet private var authorImageView: UIImageView!
    @IBOutlet private var bodyTextView: UITextView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateTimeLabel: UILabel!
//    @IBOutlet private var likeCountLabel: UILabel!
//    @IBOutlet private var optionsButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.textColor = UIColor.Theme.primaryTextColor
        dateTimeLabel.textColor = UIColor.Theme.secondaryTextColor

        bodyTextView.textContainer.lineFragmentPadding = 0
        bodyTextView.textContainerInset = .zero
        bodyTextView.textColor = UIColor.Theme.secondaryTextColor

        authorImageView.layer.cornerRadius = authorImageView.bounds.width / 2
        authorImageView.layer.masksToBounds = false

//        heartButton.imageView?.contentMode = .scaleAspectFit
        backgroundColor = UIColor.Theme.primaryColor
        renderShadow()
    }

    func bind(to viewModel: FeedItemViewModel) {
        self.viewModel = viewModel

        bodyTextView.text = viewModel.post
        nameLabel.text = viewModel.author.name
        dateTimeLabel.text = viewModel.timeSince

//        if viewModel.isLiked {
//            setHeart(to: .full)
//        } else {
//            setHeart(to: .empty)
//        }

//        optionsButton.isHidden = !viewModel.doesOwnItem
    }

    enum Heart: String {
        case full = "heart_filled"
        case empty = "heart"
    }

//    private func setHeart(to heart: Heart) {
//        heartButton.setImage(UIImage(named: heart.rawValue), for: .normal)
//    }

    @IBAction func didTapMore(sender: UIButton) {
        guard let itemId = viewModel?.itemId else { return }
        delegate?.didTapOptions(for: itemId)
    }

    @IBAction func didTapHeart(sender: UIButton) {
//        guard let viewModel = self.viewModel else { return }
//
//        UIView.animate(withDuration: 0.2,
//                       delay: 0,
//                       usingSpringWithDamping: 1,
//                       initialSpringVelocity: 1,
//                       options: [.curveEaseIn], animations: {
//            self.heartButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
//            self.generator.impactOccurred()
//        }, completion: { hasComplete in
//            UIView.animate(withDuration: 0.2, animations: { [weak self] in
//                self?.heartButton.transform = .identity
//                self?.setHeart(to: viewModel.isLiked ? .empty : .full)
//            })
//        })
    }
}
