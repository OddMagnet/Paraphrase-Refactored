//
//  ShowQuoteViewController.swift
//  Paraphrase
//
//  Created by Paul Hudson on 05/05/2018.
//  Updated / Refactored by Michael Brünen on 11.08.20.
//  Copyright © 2018 Hacking with Swift. All rights reserved.
//

import UIKit
import SwiftyBeaver

class ShowQuoteViewController: UIViewController {
    @IBOutlet var quoteLabel: UILabel!

    var quote: Quote?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let quote = quote else {
            navigationController?.popToRootViewController(animated: true)
            return
        }

        title = quote.author
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(shareQuote))

        // assign the formatted text
        quoteLabel.attributedText = quote.attributedString
    }

    @objc func shareQuote() {
        guard let quote = quote else {
            return
        }

        // share it
        let fullText = quote.multiLine
        let activity = UIActivityViewController(activityItems: [fullText], applicationActivities: nil)
        present(activity, animated: true)

        SwiftyBeaver.info("Sharing quote \(fullText)")
    }
}
