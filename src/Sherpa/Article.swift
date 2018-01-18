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

import Foundation

internal struct Article {
	
	let key: String?
	
	let title: String
	
	let body: String
    
    let html: String
	
	let buildMin: Int
	
	let buildMax: Int
	
	let relatedKeys: [String]
	
	internal init?(dictionary: [String: Any]) {
		// Key
		if let string = dictionary["key"] as? String, !string.isEmpty {
			key = string
		}
		else {
			key = nil
		}
		
		// Minimum build
		if let int = dictionary["build_min"] as? Int {
			buildMin = int
		}
		else if let string = dictionary["build_min"] as? String, let int = Int(string) {
			buildMin = int
		}
		else {
			buildMin = 1
		}
		
		// Maximum build
		if let int = dictionary["build_max"] as? Int {
			buildMax = int
		}
		else if let string = dictionary["build_max"] as? String, let int = Int(string) {
			buildMax = int
		}
		else {
			buildMax = Int.max
		}
		
		// Related articles
		if let array = dictionary["related_articles"] as? [String] {
			relatedKeys = array
		}
		else if let string = dictionary["related_articles"] as? String, !string.isEmpty {
			relatedKeys = [string]
		}
		else {
			relatedKeys = []
		}
		
		// Title and body
		title = dictionary["title"] as? String ?? ""
		body = dictionary["body"] as? String ?? ""
        html = dictionary["html"] as? String ?? ""
		if title.isEmpty || ( body.isEmpty && html.isEmpty ) {
			return nil
		}
	}
	
	internal func matches(_ query: String) -> Bool {
		if query.isEmpty {
			return true
		}
		
		let lowercaseQuery = query.lowercased()
		
		if self.title.lowercased().range(of: lowercaseQuery) != nil {
			return true
		}
			
		else if self.body.lowercased().range(of: lowercaseQuery) != nil {
			return true
		}
		
		return false
	}
	
	internal func matches(_ buildNumber: Int) -> Bool {
		return buildNumber >= self.buildMin && buildNumber <= self.buildMax
	}
	
}
