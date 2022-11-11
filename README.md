# RelativeUrls for Publish

When you write your posts, use relative paths and let this plugin rewrite the paths for hosting ready.

## Installation

To install it into your Publish package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
  dependencies: [
    .package(
      name: "RelativeUrls",
      url: "https://github.com/markbattistella/relative-urls-publish-plugin",
      from: "1.0.0"
	)
  ],
  targets: [
    .target(dependencies: ["RelativeUrls"])
  ]
)
```

## Usage

### Pipeline

The plugin can then be used within any publishing pipeline like this:

```swift
import RelativeUrls

try DeliciousRecipes().publish(using: [
  .installPlugin(.replaceRelativeUrls(site: Site))
])
```

You will need to pass in the `Website` into the plugin argument. This is so we can check if the URL is local or external.

### Markdown

When writing your markdown documents you add images or anchors using the relative path, instead of the post-rendered path.

#### Images

You can access the `/Resources/` before your pathways so within other code editors like VSCode the autocomplete will help write the paths.

```markdown
![alt text](/Resources/images/hero.jpg)
```

The output will be:

```markdown
![alt text](/images/hero.jpg)
```

#### Anchors

You can access the `/Content/` directory and all the files within it directly. It supports ID tags for jump to headings if supported.

```markdown
[My First Post](/Content/posts/my-first-post.md)

[My First Post](/Content/posts/my-first-post.md#heading)

[External](https://markbattistella.com) 
```

The output will be:

```markdown
[My First Post](/posts/my-first-post/)

[My First Post](/posts/my-first-post/#heading)

[External](https://markbattistella.com)
```

## Contributing

I've turned off Issues and if you wish to add/change the codebase please create a Pull Request.

This way everyone can allow these components to grow, and be the best rather than waiting on me to write it.

### How to help

1. Clone the repo: `git clone https://github.com/markbattistella/relative-urls-publish-plugin`
1. Create your feature branch: `git checkout -b my-feature`
1. Commit your changes: `git commit -am 'Add some feature'`
1. Push to the branch: `git push origin my-new-feature`
1. Submit the pull request
