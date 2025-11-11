import SwiftUI

extension Color {
    static var systemBackground: Color {
        #if canImport(UIKit)
        return Color(UIColor.systemBackground)
        #elseif canImport(AppKit)
        return Color(NSColor.windowBackgroundColor)
        #else
        return Color.white
        #endif
    }
    
    static var systemGray6: Color {
        #if canImport(UIKit)
        return Color(UIColor.systemGray6)
        #elseif canImport(AppKit)
        // Closest reasonable fallback on macOS
        return Color(NSColor.controlBackgroundColor)
        #else
        return Color.gray.opacity(0.1)
        #endif
    }
}
