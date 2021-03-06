//
// Copyright © 2021 Daniel Farrelly
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

import Foundation

internal struct Section {
	
	let title: String?
	
	let detail: String?
	
	let articles: [Article]
	
	internal init?(dictionary: [String: Any]) {
		// Title
		if let string = dictionary["title"] as? String, !string.isEmpty {
			title = string
		}
		else {
			title = nil
		}
		
		// Detail
		if let string = dictionary["detail"] as? String, !string.isEmpty {
			detail = string
		}
		else {
			detail = nil
		}
		
		// Articles
		articles = (dictionary["articles"] as? [[String: Any]])?.map({ Article(dictionary: $0) }).compactMap({ $0 }) ?? []
		if articles.count == 0 {
			return nil
		}
	}
	
	internal init(title: String?, detail: String?, articles: [Article]!) {
		self.title = title
		self.detail = detail
		self.articles = articles
	}
	
	internal func section(_ filter: (Article) -> Bool) -> Section? {
		let articles = self.articles.filter(filter)
		
		if articles.count == 0 {
			return nil
		}
		
		return Section(title: self.title, detail: self.detail, articles: articles)
	}
	
	internal func section(_ query: String) -> Section? {
		return self.section { $0.matches(query) }
	}
	
	internal func section(_ buildNumber: Int) -> Section? {
		return self.section { $0.matches(buildNumber) }
	}
	
}
