//
//  Created by Mark Battistella
//	@markbattistella
//

import Ink
import Plot
import Publish


// MARK: - create the plugin
public extension Plugin {
	static func replaceRelativeUrls<Site : Website>(site: Site) -> Self {
		Plugin(name: "RelativeUrl") { context in
			context.markdownParser.addModifier(
				.replaceRelativeImageUrls()
			)

			context.markdownParser.addModifier(
				.replaceRelativeAnchorUrls(site: site)
			)
		}
	}
}

// MARK: - create the modifiers
public extension Modifier {
	internal static func replaceRelativeImageUrls() -> Self {
		Modifier(target: .images) { html, markdown in
			return Builder()
				.replaceImagePath(html: html, markdown: markdown)
		}
	}

	internal static func replaceRelativeAnchorUrls<Site : Website>(site: Site) -> Self {
		Modifier(target: .links) { html, markdown in
			return Builder()
				.replaceAnchorPath(site: site, html: html, markdown: markdown)
		}

	}
}
