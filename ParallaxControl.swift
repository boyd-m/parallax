import UIKit

@IBDesignable class ParallaxControl: UIView {
    
    var value = 0.5 {
        didSet {
            updateImagePositions()
        }
    }
    
    // Ensure that images are repositioned accordingly on resize
    override var bounds: CGRect {
        didSet {
            updateImagePositions()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateImagePositions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateImagePositions()
    }
    
    private func updateImagePositions() {
        subviews
            .compactMap { subview in subview as? ParallaxImage }
            .forEach(updateImagePosition)
    }
    
    private func updateImagePosition(imageView: ParallaxImage) {
        if let image = imageView.image {
            imageView.frame = getImageFrame(image, imageView.scrolliness, frame)
        }
    }
    
    private func getImageFrame(_ image: UIImage, _ scrolliness: Double, _ parentFrame: CGRect) -> CGRect {
        
        let aspect = image.size.width / image.size.height
        let width = parentFrame.height * aspect
        
        let xMin = CGFloat.zero
        let xMax = parentFrame.width - width
        
        // Adjust for scrolliness
        let scrollinessModifier = CGFloat(1.0 - scrolliness) * xMax / 2.0
        let xMinAdjusted = xMin + scrollinessModifier
        let xMaxAdjusted = xMax - scrollinessModifier
        
        let x = xMinAdjusted + (xMaxAdjusted - xMinAdjusted) * CGFloat(value)
        
        return CGRect(
            x: x,
            y: 0.0,
            width: width,
            height: parentFrame.height)
    }
}
