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

    @IBOutlet private var authorImageView: UIImageView!
    @IBOutlet private var bodyTextView: UITextView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateTimeLabel: UILabel!
    @IBOutlet private var optionsButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        dateTimeLabel.textColor = UIColor.Theme.secondaryTextColor

        bodyTextView.textContainer.lineFragmentPadding = 0
        bodyTextView.textContainerInset = .zero
        bodyTextView.textColor = UIColor.Theme.secondaryTextColor

        authorImageView.layer.cornerRadius = authorImageView.bounds.width / 2
        authorImageView.layer.masksToBounds = false

        backgroundColor = UIColor.Theme.primaryColor
        renderShadow()

        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didPerformLongTap(gesture:)))
        addGestureRecognizer(gesture)
    }

    @objc private func didPerformLongTap(gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        guard viewModel?.doesOwnItem == true else { return }
        guard let itemId = viewModel?.itemId else { return }

        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn], animations: {
                        self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                        self.generator.impactOccurred()

                        self.delegate?.didTapOptions(for: itemId)
        }, completion: { hasComplete in
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.transform = .identity
            })
        })

    }

    func bind(to viewModel: FeedItemViewModel) {
        self.viewModel = viewModel

        bodyTextView.text = viewModel.post
        nameLabel.text = viewModel.author.name
        dateTimeLabel.text = viewModel.timeSince

        if viewModel.doesOwnItem {
            nameLabel.textColor = UIColor.Theme.accentColor
        } else {
            nameLabel.textColor = UIColor.Theme.primaryTextColor
        }

        optionsButton.isHidden = !viewModel.doesOwnItem
    }

    @IBAction func didTapMore(sender: UIButton) {
        guard let itemId = viewModel?.itemId else { return }
        delegate?.didTapOptions(for: itemId)
    }
}
