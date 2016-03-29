import UIKit

extension UIImage {
    func darkenImage() -> UIImage {
        let context = CIContext()
        let input = CoreImage.CIImage(image: self) // https://twitter.com/gernot/status/508169187379146752
        
        let filter = CIFilter(name: "CIExposureAdjust")
        filter.setValue(input, forKey: "inputImage")
        filter.setValue(-2, forKey: "inputEV")
        
        let cgImage = context.createCGImage(filter!.outputImage!,
                                              fromRect: filter!.outputImage!.extent)

        let output = UIImage(CGImage: cgImage)
        return output!
    }
}
