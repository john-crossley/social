//
//  FeedCell.swift
//  Social
//
//  Created by John Crossley on 11/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    private let generator = UIImpactFeedbackGenerator(style: .light)

    @IBOutlet private var heartButton: UIButton!
    @IBOutlet private var bodyTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        bodyTextView.textContainer.lineFragmentPadding = 0
        bodyTextView.textContainerInset = .zero

        heartButton.imageView?.contentMode = .scaleAspectFit

        backgroundColor = UIColor(named: "primaryColor")
    }

    func bind(model: Feed) {
        self.bodyTextView.text = model.post
    }

    @IBAction func didTapHeart(sender: UIButton) {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [.curveEaseIn], animations: {
            self.heartButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            self.generator.impactOccurred()
        }, completion: { hasComplete in
            UIView.animate(withDuration: 0.2, animations: {
                self.heartButton.transform = .identity
                self.heartButton.setImage(UIImage(named: "heart_filled"), for: .normal)
            })
        })
    }
}
