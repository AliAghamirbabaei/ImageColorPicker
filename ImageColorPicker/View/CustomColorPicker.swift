//
//  CustomColorPicker.swift
//  ImageColorPicker
//
//  Created by Ali Aghamirbabaei on 2/1/22.
//

import SwiftUI

// MARK: Making extension to call Image Color Picker
extension View {
    func imageColorPicker(showPicker: Binding<Bool>, color: Binding<Color>) -> some View {
        return self
        // Full Sheet
            .fullScreenCover(isPresented: showPicker) {
                
            } content: {
                NavigationView{
                    CustomColorPicker(color: color)
                        .navigationTitle("Image Color Picker")
                        .navigationBarTitleDisplayMode(.inline)
                    // MARK: Close Button
                        .toolbar {
                            Button("Close"){
                                showPicker.wrappedValue.toggle()
                            }
                        }
                }
            }
    }
}

// MARK: Custom Color Picker with the Help if UIColorPicker
struct CustomColorPicker: UIViewControllerRepresentable {
    
    // MARK: Picker Values
    @Binding var color: Color
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = false
        picker.selectedColor = UIColor(color)
        
        // Connecting Delegate
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
        
    }
    
    // MARK: Delegate Methods
    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var parent: CustomColorPicker
        
        init(parent: CustomColorPicker){
            self.parent = parent
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            // Updating Color
            parent.color = Color(viewController.selectedColor)
        }
        
        func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
            parent.color = Color(color)
        }
    }
}
