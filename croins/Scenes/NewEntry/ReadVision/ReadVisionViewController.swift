import UIKit
import AVFoundation
import Vision

class ReadVisionViewController: UIViewController {
    
    // MARK: - UI Objects
    lazy var previewView: PreviewView = {
        var view = PreviewView()
        view.backgroundColor = .white
        view.isOpaque = true
        return view
    }()
    
    private lazy var cutoutView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var maskLayer = CAShapeLayer()
    var currentOrientation = UIDeviceOrientation.portrait
    
    // MARK: - Capture Related Objects
    private let captureSession = AVCaptureSession()
    let captureSessionQueue = DispatchQueue(label: "captureSessionQueue")
    var captureDevice: AVCaptureDevice?
    var videoDataOutput = AVCaptureVideoDataOutput()
    let videoDataOutputQueue = DispatchQueue(label: "captureSessionQueue")
    
    // MARK: - Region of Interest (ROI) and Text Orientation
    var regionOfInterest = CGRect(x: 0, y: 0, width: 1, height: 1)
    var textOrientation = CGImagePropertyOrientation.up
    
    // MARK: - Coordinate transform
    var bufferAspectRatio: Double!
    var uiRotationTransform = CGAffineTransform.identity
    var bottomToTopTransform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
    var roiToGlobalTransform = CGAffineTransform.identity
    
    var visionToAVFTransform = CGAffineTransform.identity
    
    // MARK: - View Controller Methods
    
    init () {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        
        previewView.session = captureSession
        
        cutoutView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.fillRule = .evenOdd
        cutoutView.layer.mask = maskLayer
        
        captureSessionQueue.async {
            self.setupCamera()
            DispatchQueue.main.async {
                self.calculateRegionOfInterest()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let deviceOrientation = UIDevice.current.orientation
        if deviceOrientation.isPortrait || deviceOrientation.isLandscape {
            currentOrientation = deviceOrientation
        }
        
        if let videoPreviewLayerConnection = previewView.videoPreviewLayer.connection {
            if let newVideoOrientation = AVCaptureVideoOrientation(deviceOrientation: deviceOrientation) {
                videoPreviewLayerConnection.videoOrientation = newVideoOrientation
            }
        }
        
        calculateRegionOfInterest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCutout()
    }
    
    // MARK: - Setup
    
    func calculateRegionOfInterest() {
        let desiredHeightRatio = 0.6
        let desiredWidthRatio = 0.6
        let maxPortraitWidth = 0.8
        
        let size: CGSize
        if currentOrientation.isPortrait || currentOrientation == .unknown {
            size = CGSize(width: min(desiredWidthRatio * bufferAspectRatio, maxPortraitWidth), height: desiredHeightRatio / bufferAspectRatio)
        } else {
            size = CGSize(width: desiredWidthRatio, height: desiredHeightRatio)
        }
        regionOfInterest.origin = CGPoint(x: (1 - size.width) / 2, y: (1 - size.height) / 2)
        regionOfInterest.size = size
        
        setupOrientationAndTransform()
        
        DispatchQueue.main.async {
            self.updateCutout()
        }
    }
    
    func updateCutout() {
        let roiRectTransform = bottomToTopTransform.concatenating(uiRotationTransform)
        let cutout = previewView.videoPreviewLayer.layerRectConverted(fromMetadataOutputRect: regionOfInterest.applying(roiRectTransform))
        
        let path = UIBezierPath(rect: cutoutView.frame)
        path.append(UIBezierPath(rect: cutout))
        maskLayer.path = path.cgPath
    }
    
    func setupOrientationAndTransform() {
        let roi = regionOfInterest
        roiToGlobalTransform = CGAffineTransform(translationX: roi.origin.x, y: roi.origin.y).scaledBy(x: roi.width, y: roi.height)
        
        switch currentOrientation {
        case .landscapeLeft:
            textOrientation = CGImagePropertyOrientation.up
            uiRotationTransform = CGAffineTransform.identity
        case .landscapeRight:
            textOrientation = CGImagePropertyOrientation.down
            uiRotationTransform = CGAffineTransform(translationX: 1, y: 1).rotated(by: CGFloat.pi)
        case .portraitUpsideDown:
            textOrientation = CGImagePropertyOrientation.left
            uiRotationTransform = CGAffineTransform(translationX: 1, y: 0).rotated(by: CGFloat.pi / 2)
        default:
            textOrientation = CGImagePropertyOrientation.right
            uiRotationTransform = CGAffineTransform(translationX: 0, y: 1).rotated(by: -CGFloat.pi / 2)
        }
        
        visionToAVFTransform = roiToGlobalTransform.concatenating(bottomToTopTransform).concatenating(uiRotationTransform)
    }
    
    func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) else {
            print("Could not create capture device.")
            return
        }
        self.captureDevice = captureDevice
        
        if captureDevice.supportsSessionPreset(.hd4K3840x2160) {
            captureSession.sessionPreset = AVCaptureSession.Preset.hd4K3840x2160
            bufferAspectRatio = 3840.0 / 2160.0
        } else {
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
            bufferAspectRatio = 1920.0 / 1080.0
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            print("Could not create device input.")
            return
        }
        if captureSession.canAddInput(deviceInput) {
            captureSession.addInput(deviceInput)
        }
        
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
            videoDataOutput.connection(with: AVMediaType.video)?.preferredVideoStabilizationMode = .off
        } else {
            print("Could not add VDO output")
            return
        }
        
        do {
            try captureDevice.lockForConfiguration()
            captureDevice.videoZoomFactor = 2
            captureDevice.autoFocusRangeRestriction = .near
            captureDevice.unlockForConfiguration()
        } catch {
            print("Could not set zoom level due to error: \(error)")
            return
        }
        
        captureSession.startRunning()
    }
    
    // MARK: - UI drawing and interaction
    
    func showString(string: [String]) {
        captureSessionQueue.sync {
            self.captureSession.stopRunning()
            /// Colocar resultado da busca
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Dados coletados!", message: String(format: "Gasto de R$ %@ em %@", string[1], string[0]), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { _ in
                    guard let value = Double(string[1].replacingOccurrences(of: ",", with: ".")) else { return }
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    guard let date = formatter.date(from: string[0]) else { return }
                    AppDatabase.shared.add(out: .init(
                        title: "No title",
                        value: value,
                        date: date,
                        category: AppDatabase.shared.categories[0]))
                    self.navigationController?.viewControllers.removeLast()
                }))
                alert.addAction(UIAlertAction(title: "Buscar novamente", style: .cancel, handler: { _ in
                    self.captureSession.startRunning()
                }))
                alert.addAction(UIAlertAction(title: "Cancelar busca", style: .destructive, handler: { _ in
                    self.navigationController?.viewControllers.removeLast()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func addSubviews() {
        view.addSubview(previewView)
        view.addSubview(cutoutView)
    }
    
    func setupConstraints() {
        previewView.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        }
        
        cutoutView.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        }
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension ReadVisionViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // This is implemented in VisionViewController.
    }
}

// MARK: - Utility extensions

extension AVCaptureVideoOrientation {
    init?(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeRight
        case .landscapeRight: self = .landscapeLeft
        default: return nil
        }
    }
}
