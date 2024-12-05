import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var canvasView: CustomCanvasView
    @State var backgroundColor: UIColor = UIColor(Color(hex: "#FFFEF8"))
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = backgroundColor
        return canvasView
    }
    

    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // Update the view
    }
}

class CustomCanvasView: PKCanvasView {
    
    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        // Check if the touch is coming from an Apple Pencil
        if let touch = touches.first, touch.type == .pencil {
            return true // Allow the touch
        }
        return false // Ignore finger touches
    }
}

struct DrawingView: View {
    @State private var canvasView = CustomCanvasView()
    @Binding var isDrawing: Bool
    @Binding var drawing: PKDrawing
    @State private var toolPicker = PKToolPicker()
    @State private var backgroundColor = Color(hex: "#FFFEF8")
    @State private var canvasHeight: CGFloat = 300 // Initial height of the canvas
    var onSave: (PKDrawing) -> Void

    var body: some View {
        VStack {
            CanvasView(canvasView: $canvasView)
                .frame(height: canvasHeight)
                .background(Color(hex: "#FFFEF8"))
                .onAppear {
                    toolPicker.setVisible(true, forFirstResponder: canvasView)
                    toolPicker.addObserver(canvasView)
                    canvasView.becomeFirstResponder()
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newHeight = canvasHeight + value.translation.height
                            if newHeight >= 200 {
                                canvasHeight = newHeight
                            }
                        }
                )

            HStack {
                Button(action: {
                    drawing = canvasView.drawing
                    onSave(drawing)
                    isDrawing = false
                }) {
                    Text("Save Drawing")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationBarTitle("Drawing")
    }

    func saveDrawing() {
        let drawing = canvasView.drawing
        let data = drawing.dataRepresentation()
        let url = getDocumentsDirectory().appendingPathComponent("drawing.data")
        do {
            try data.write(to: url)
            print("Drawing saved successfully.")
        } catch {
            print("Failed to save drawing: \(error.localizedDescription)")
        }
    }

    func loadDrawing() {
        let url = getDocumentsDirectory().appendingPathComponent("drawing.data")
        do {
            let data = try Data(contentsOf: url)
            let drawing = try PKDrawing(data: data)
            canvasView.drawing = drawing
            print("Drawing loaded successfully.")
        } catch {
            print("Failed to load drawing: \(error.localizedDescription)")
        }
    }

    // Helper function to get the documents directory
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct DrawingView2: View {
    @State private var canvasView = CustomCanvasView()
    @Binding var drawing: PKDrawing
    @State private var toolPicker = PKToolPicker()
    @State private var backgroundColor = Color(hex: "#FFFEF8")
    @State private var canvasHeight: CGFloat = 300 // Initial height of the canvas
    var onSave: (PKDrawing) -> Void

    var body: some View {
        VStack {
            CanvasView(canvasView: $canvasView)
                .frame(height: canvasHeight)
                .background(Color(hex: "#FFFEF8"))
                .onAppear {
                    toolPicker.setVisible(true, forFirstResponder: canvasView)
                    toolPicker.addObserver(canvasView)
                    canvasView.becomeFirstResponder()
                    loadDrawing() // Load the drawing when the view appears
                }
                .onDisappear {
                    saveDrawing() // Save the drawing when the view disappears
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newHeight = canvasHeight + value.translation.height
                            if newHeight >= 200 {
                                canvasHeight = newHeight
                            }
                        }
                )
        }
        .navigationBarTitle("View Drawing")
    }

    func saveDrawing() {
        drawing = canvasView.drawing
        onSave(drawing) // Call onSave when saving the drawing
        let data = drawing.dataRepresentation()
        let url = getDocumentsDirectory().appendingPathComponent("drawing.data")
        do {
            try data.write(to: url)
            print("Drawing saved successfully.")
        } catch {
            print("Failed to save drawing: \(error.localizedDescription)")
        }
    }

    func loadDrawing() {
        let url = getDocumentsDirectory().appendingPathComponent("drawing.data")
        do {
            let data = try Data(contentsOf: url)
            let drawing = try PKDrawing(data: data)
            canvasView.drawing = drawing
            print("Drawing loaded successfully.")
        } catch {
            print("Failed to load drawing: \(error.localizedDescription)")
        }
    }

    // Helper function to get the documents directory
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

