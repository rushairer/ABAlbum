//
//  AlbumPage.swift
//  ABAlbum
//
//  Created by Abenx on 2021/7/27.
//

import SwiftUI
import Photos

/// The base page for Album.
///
/// You need request PHAuthorizationStatus first, and decide whether to display NoPermissionView using a Boolen binding.
///
/// ```swift
///
///  @State var showsAlbumNoPermissionView: Bool = AlbumAuthorizationStatus.isNotDetermined
///
///  var body: some View {
///     AlbumPage()
///         .showsNoPermissionView($showsAlbumNoPermissionView)
///         .albumFetchOptions(AlbumFetchOptions.fetchOptions(with: mediaType))
///         .task {
///             showsAlbumNoPermissionView = await !AlbumAuthorizationStatus.hasAlbumPermission
///         }
///  }
///
/// ```
public struct AlbumPage: View {
    
    public init() {}
    
    public var body: some View {
        AlbumSelectorGridView()
    }
}

extension AlbumPage {
    
    /// Show the NoPermissionView.
    /// - Parameter showsAlbumNoPermissionView: Binding<Bool>
    /// - Returns: AlbumPage
    public func showsNoPermissionView(_ showsAlbumNoPermissionView: Binding<Bool>) -> some View {
        self.modifier(ShowsNoPermissionView(showsAlbumNoPermissionView: showsAlbumNoPermissionView))
    }
    
    struct ShowsNoPermissionView: ViewModifier {
        @Binding var showsAlbumNoPermissionView: Bool
        
        func body(content: Content) -> some View {
            content
                .overlay(
                    AlbumNoPermissionView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.background)
                        .opacity(showsAlbumNoPermissionView ? 1 : 0)
                )
        }
    }
}

struct AlbumPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlbumPage()
            AlbumPage().showsNoPermissionView(.constant(true))
        }
    }
}
