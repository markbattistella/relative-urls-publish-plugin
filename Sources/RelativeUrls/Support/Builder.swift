//
//  Created by Mark Battistella
//	markbattistella.com
//

import Foundation
import Publish
import Ink
import Plot

// MARK: - the magic
final class Builder {

	// -- replace relative urls for anchors
	// -- it will transform urls in the markdown files as such:
	// -- [My First Post](/Content/posts/my-first-post.md)         ---> [My First Post](/posts/my-first-post/)
	// -- [My First Post](/Content/posts/my-first-post.md#heading) ---> [My First Post](/posts/my-first-post/#heading)
	// -- [External](https://markbattistella.com)                  ---> [External](https://markbattistella.com)
	func replaceAnchorPath<Site: Website>(site: Site, html: String, markdown: Substring) -> String {

		// -- regex: get everything before Content
		let regex = #"^(.*?Content)"#

		// -- get the text component
		guard let text = markdown.content(delimitedBy: .squareBrackets) else { return html }

		// -- get the link component
		guard let link = markdown.content(delimitedBy: .parentheses) else { return html }

		// -- get the components
		guard let url = URL(string: String(link)),
			  let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return html }

		// -- create the relative url
		guard let originalURL = components.url?.path else { return html }

		// -- convert the original path url to relative
		var relativeURL: String {
			let path = originalURL.replacingOccurrences(of: regex, with: "", options: .regularExpression)
			return path.hasSuffix(".md") ? String(path.dropLast(3)) : path
		}

		// -- add in the fragment
		var fullRelativeURL: String {
			guard let fragment = components.fragment else { return relativeURL }
			if !fragment.isEmpty {
				return "\(relativeURL)/#\(fragment)"
			}
			return String(link)
		}

		// -- check if link is internal or external
		var isExternalHost: Bool {
			guard let host = components.host else { return false }
			if host == site.url.host {
				return false
			}
			return true
		}

		// build the node
		var node: Node<HTML.BodyContext> {
			.a(.text(String(text)),
			   .href(isExternalHost ? String(link) : fullRelativeURL),
			   .if(isExternalHost,
				   .group(.target(.blank),
						  .rel(.nofollow),
						  .class("link-external")
				   )
			   )
			)
		}

		// -- render the output
		return node.render()
	}



	// -- replace relative urls for images
	// -- it will transform urls in the markdown files as such:
	// -- ![alt text](/Resources/images/hero.jpg) ---> ![alt text](/images/hero.jpg)
	func replaceImagePath(html: String, markdown: Substring) -> String {

		// -- regex: get everything before Resources
		let regex = #"^(.*?Resources)"#

		// -- get the text component
		guard let text = markdown.content(delimitedBy: .squareBrackets) else { return html }

		// -- get the link component
		guard let link = markdown.content(delimitedBy: .parentheses) else { return html }

		// -- get the attributes
		let parts: [String] = link
			.components(separatedBy: CharacterSet.whitespaces)

		// -- create the relative url
		let relativeURL = parts[0]
			.replacingOccurrences(of: regex, with: "", options: .regularExpression)

		// -- build the node
		var node: Node<HTML.BodyContext> {
			.img(.src(relativeURL),
				 .alt(String(text)),
				 .title(String(text))
			)
		}

		// -- render the output
		return node.render()
	}
}
