Pod::Spec.new do |s|
    s.name             = "InstantSearchVoiceOverlay"
    s.module_name      = 'InstantSearchVoiceOverlay'
    s.version          = "1.1.0"
    s.summary          = "A beautiful voice overlay widget that records the user's voice input"
    s.homepage         = "https://github.com/algolia/voice-overlay-ios"
    s.license          = { type: 'MIT', file: 'LICENSE.md' }
    s.author           = { "Algolia" => "contact@algolia.com" }
    s.source           = { git: "https://github.com/algolia/voice-overlay-ios.git", tag: s.version.to_s }
    s.social_media_url = 'https://twitter.com/algolia'
    s.platforms = { :ios => "10.0" }
    s.requires_arc = true
    s.swift_version = '5.3'
    s.source_files = [
        'Sources/InstantSearchVoiceOverlay/**/*.{swift}'
    ]
    s.resources = [
        "Sources/InstantSearchVoiceOverlay/Views/Assets.xcassets",
        "Sources/InstantSearchVoiceOverlay/Sound/*"
    ]
end
