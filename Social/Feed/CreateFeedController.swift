//
//  NewFeedItemController.swift
//  Social
//
//  Created by John Crossley on 13/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class CreateFeedController: UIViewController {

    private let viewModel: FeedViewModel

    @IBOutlet private var bodyTextField: UITextView! {
        didSet {
            bodyTextField.becomeFirstResponder()
        }
    }

    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CreateFeedController", bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func didTapClose(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapSubmit(sender: UIButton) {
        viewModel.post(body: bodyTextField.text, callback: { [unowned self] result in
            switch result {
            case .success:
                self.dismiss(animated: true, completion: nil)
            case .error:
                break
            }
        })
    }
}
