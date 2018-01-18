//
// Copyright © 2017 Daniel Farrelly
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// *	Redistributions of source code must retain the above copyright notice, this list
//		of conditions and the following disclaimer.
// *	Redistributions in binary form must reproduce the above copyright notice, this
//		list of conditions and the following disclaimer in the documentation and/or
//		other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import UIKit
import WebKit

internal class ArticleViewController: ListViewController {
	
	// MARK: Instance life cycle
	
	internal let article: Article!
	
	init(document: Document, article: Article) {
		self.article = article
		
		super.init(document: document)
		
		self.dataSource.sectionTitle = NSLocalizedString("Related", comment: "Title for table view section containing one or more related articles.")
		self.dataSource.filter = { (article: Article) -> Bool in return article.key != nil && self.article.relatedKeys.contains(article.key!)  }
		
		self.allowSearch = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: View life cycle
	
	internal let contentView: UIView! = UIView()
	
	internal let titleLabel: UILabel! = UILabel()
	
	internal let bodyView: UITextView! = UITextView()
    
    internal let htmlView: WKWebView! = WKWebView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = nil
		
		self.contentView.preservesSuperviewLayoutMargins = true
		self.contentView.translatesAutoresizingMaskIntoConstraints = false
		
		if #available(iOSApplicationExtension 9.0, *) {
			self.titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)
		} else {
			self.titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
		}
		self.titleLabel.textColor = self.dataSource.document.articleTextColor
		self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
		self.titleLabel.numberOfLines = 0
		self.contentView.addSubview(self.titleLabel)
		
		self.titleLabel.text = self.article.title
		
        if self.article.html.count > 0 {
            self.htmlView.isOpaque = false
            self.htmlView.backgroundColor = UIColor.clear
            self.htmlView.loadHTMLString(self._applyStyle(toString: self.article.html), baseURL: nil)
            self.contentView.addSubview(self.htmlView)
        }
        else {
            self.bodyView.backgroundColor = UIColor.clear
            self.bodyView.isEditable = false
            self.bodyView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
            self.bodyView.textColor = self.dataSource.document.articleTextColor
            self.bodyView.tintColor = self.dataSource.document.tintColor
            self.bodyView.translatesAutoresizingMaskIntoConstraints = false
            self.bodyView.textContainer.lineFragmentPadding = 0
            self.bodyView.textContainerInset = UIEdgeInsets.zero
            self.contentView.addSubview(self.bodyView)
            
            self.bodyView.attributedText = self._applyAttributes(toString: self.article.body)
        }
        
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.setNavigationBarHidden(false, animated: false)
	}
	
	override func viewDidLayoutSubviews() {
		let header = self.contentView
		if header?.superview == nil || header?.frame.width != header?.superview!.frame.width {
			let margins = self.tableView.layoutMargins
			let width = self.tableView.frame.width
			
			let maxSize = CGSize(width: width - margins.left - margins.right, height: CGFloat.greatestFiniteMagnitude)
			let titleSize = self.titleLabel.sizeThatFits(maxSize)
			self.titleLabel.frame = CGRect(x: margins.left, y: 30, width: maxSize.width, height: titleSize.height)
            
            if self.article.html.count > 0 {
                let htmlSize = self.tableView.frame.height * 0.6    // Fixed height
                
                self.htmlView.frame = CGRect(x: margins.left, y: self.titleLabel.frame.maxY + 15, width: maxSize.width, height: htmlSize)
                header?.frame = CGRect(x: 0, y: 0, width: width, height: self.htmlView.frame.maxY)
            }
            else {
                let bodySize = self.bodyView.sizeThatFits(maxSize)
                
                self.bodyView.frame = CGRect(x: margins.left, y: self.titleLabel.frame.maxY + 15, width: maxSize.width, height: bodySize.height)
                header?.frame = CGRect(x: 0, y: 0, width: width, height: self.bodyView.frame.maxY)

            }
			
			self.tableView.tableHeaderView = header
		}
	}
	
	@_semantics("optimize.sil.never")
	fileprivate func _applyAttributes(toString string: String?) -> NSAttributedString? {
		guard let string = string else {
			return nil
		}
		
		var mutable = string
		
		while let range = mutable.range(of: "\n") {
			mutable.replaceSubrange(range, with: "<br />")
		}
		
		guard let data = mutable.data(using: String.Encoding.unicode, allowLossyConversion: false) else {
			return nil
		}
		
		do {
			let attributedText = try NSMutableAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
			
			attributedText.beginEditing()
			attributedText.enumerateAttributes(in: NSMakeRange(0,attributedText.length), options: [], using: { attributes, range, stop in
				var mutable = attributes
				
				if let font = mutable[NSFontAttributeName] as? UIFont {
					let symbolicTraits = font.fontDescriptor.symbolicTraits
					let descriptor = self.bodyView.font!.fontDescriptor.withSymbolicTraits(symbolicTraits)
					
					if font.familyName == "Times New Roman" {
						mutable[NSFontAttributeName] = UIFont(descriptor: descriptor!, size: self.bodyView.font!.pointSize)
					}
						
					else {
						mutable[NSFontAttributeName] = font.withSize(self.bodyView.font!.pointSize)
					}
				}
				
				
				if mutable[NSLinkAttributeName] != nil {
					mutable[NSForegroundColorAttributeName] = self.bodyView.tintColor
					mutable[NSStrokeColorAttributeName] = self.bodyView.tintColor
				}
					
				else {
					mutable[NSForegroundColorAttributeName] = self.bodyView.textColor
				}
				
				attributedText.setAttributes(mutable, range: range)
			})
			attributedText.endEditing()
			
			return attributedText
		}
			
		catch {
			return nil
		}
	}
	
    fileprivate func _applyStyle(toString string: String) -> String {
        
        let styled = "<style>body{ font-family: 'HelveticaNeue', 'Arial', 'Serif'; font-size: 44px; background-color: #efeff4 }</style><body>\(string)</body>"
        
        return styled
        
        
    }
}
