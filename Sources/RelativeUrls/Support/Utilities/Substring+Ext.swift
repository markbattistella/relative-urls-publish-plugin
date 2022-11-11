//
//  Created by Mark Battistella
//	markbattistella.com
//

import Foundation

// from: https://github.com/finestructure/ImageAttributesPublishPlugin
extension Substring {
	func content(delimitedBy delimiter: Delimiter) -> Substring? {

		guard let delimPos = self.firstIndex(of: delimiter.opening) else {
			return nil
		}

		let start = self.index(after: delimPos)

		guard let end = self.firstIndex(of: delimiter.closing) else {
			return nil
		}

		guard start <= end else {
			return nil
		}

		return self[start..<end]
	}
}
