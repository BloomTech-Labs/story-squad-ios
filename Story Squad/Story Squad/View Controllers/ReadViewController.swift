//
//  PDFViewController.swift
//  Story Squad
//
//  Created by Jonalynn Masters on 3/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import PDFKit

class ReadViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    @IBOutlet weak var progressView: PageCountProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPDFView()
        loadPDF()
        NotificationCenter.default.addObserver(self, selector: #selector(pageHasTurned), name: .PDFViewPageChanged, object: nil)
        
    }

    func setupPDFView() {
        
        pdfView.displayDirection = .horizontal
        pdfView.usePageViewController(true)
        pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pdfView.autoScales = true
    }
    
    func loadPDF() {
        guard let path = Bundle.main.url(forResource: "white_nights", withExtension: "pdf") else { return }
        pdfView.document = PDFDocument(url: path)
    }
    
    @objc func pageHasTurned() {
        if let document = pdfView.document,
            let currentPage = pdfView.currentPage {
            let currentPageNumber = document.index(for: currentPage)
            let totalPages = document.pageCount
            let progress: CGFloat = (currentPageNumber > 0 ? CGFloat(currentPageNumber) : 0.01) / CGFloat(totalPages)
            progressView.progress = progress
            progressView.setNeedsDisplay()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

