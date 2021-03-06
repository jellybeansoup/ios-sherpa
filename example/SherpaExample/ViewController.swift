//
// Copyright © 2019 Daniel Farrelly
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
import Sherpa

class ViewController: UIViewController {

	let guideURL = Bundle.main.url(forResource: "UserGuide", withExtension: "json")!

	@IBAction func openUserGuide() {
		let viewController = SherpaViewController(fileAtURL: guideURL)
		self.present(viewController, animated: true, completion: nil)
	}
	
	@IBAction func openArticle() {
		let viewController = SherpaViewController(fileAtURL: guideURL)
		viewController.articleKey = "body"
		self.present(viewController, animated: true, completion: nil)
	}
	
	@IBAction func pushUserGuide() {
		let viewController = SherpaViewController(fileAtURL: guideURL)
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
	@IBAction func pushArticle() {
		let viewController = SherpaViewController(fileAtURL: guideURL)
		viewController.articleKey = "body"
		viewController.articleCSS = "h1, h2, h3, h4, h5, h6 { color: magenta; }"
		self.navigationController?.pushViewController(viewController, animated: true)
	}
	
}
