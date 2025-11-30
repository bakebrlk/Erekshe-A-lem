import SwiftUI

public struct TestView: View {
    @StateObject var viewModel: TestViewModel
    
    public init() {
        _viewModel = StateObject(
            wrappedValue: TestViewModel(
                dependencies: TestViewModel.Dependencies()
            )
        )
    }

    public var body: some View {

    }

    private var displayBody: some View {

    }

}

extension TestView {
    public struct Dependencies {
        let
        
        public init(
            
        ) {
            
        }
    }
}
