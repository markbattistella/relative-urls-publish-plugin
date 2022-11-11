//
//  Created by Mark Battistella
//	markbattistella.com
//

import Foundation

enum Delimiter {
	case squareBrackets
	case parentheses

	var opening: Character {
		switch self {
			case .squareBrackets: return "["
			case .parentheses: return "("
		}
	}

	var closing: Character {
		switch self {
			case .squareBrackets: return "]"
			case .parentheses: return ")"
		}
	}
}
