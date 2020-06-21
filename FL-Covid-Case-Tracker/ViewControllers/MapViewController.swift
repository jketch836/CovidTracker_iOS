//
//  MapViewController.swift
//  FL-Covid-Case-Tracker
//
//  Created by Josh Ketcham on 5/31/20.
//  Copyright © 2020 jketch. All rights reserved.
//

import UIKit
import MapKit
import FloatingPanel

class MapViewController: UIViewController, PresentProtocol
{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D?
    
    let cvm = CovidViewModel()
    lazy var fpc: FloatingPanelController = FloatingPanelController()
    var chartVC: ChartViewController!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        locationManager.startUpdatingLocation()
        
        self.cvm.getUSAData()

        self.cvm.loadedGraph = {

            DispatchQueue.main.async {
                self.setTitle()
                self.fpc.delegate = self
                self.fpc.surfaceView.backgroundColor = .clear
                if #available(iOS 11, *) {
                    self.fpc.surfaceView.cornerRadius = 9.0
                } else {
                    self.fpc.surfaceView.cornerRadius = 0.0
                }
                self.fpc.surfaceView.shadowHidden = false
                
                self.chartVC = ChartViewController(with: self.cvm)
                
                self.fpc.set(contentViewController: self.chartVC)
                self.fpc.track(scrollView: self.chartVC.collectionView)
                self.fpc.addPanel(toParent: self, animated: true)
            }
        
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
}

extension MapViewController: MKMapViewDelegate
{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let lastLocation: CLLocation = locations[locations.count - 1]
        animateMap(lastLocation)
    }
    
    func animateMap(_ location: CLLocation)
    {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        self.mapView.setRegion(region, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if (annotation is MKUserLocation)
        {
            return nil
        }
        
        for annotation in mapView.annotations
        {
            mapView.removeAnnotation(annotation)
        }
        if (annotation.isKind(of: CovidAnnotation.self))
        {
            let customAnnotation = annotation as? CovidAnnotation
            mapView.translatesAutoresizingMaskIntoConstraints = false
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CovidAnnotation")
            
            if (annotationView == nil)
            {
                annotationView!.tintColor = UIColor.blue
                annotationView = (customAnnotation?.annotationView())!
            }
            else
            {
                annotationView!.annotation = annotation;
                annotationView!.tintColor = UIColor.blue
            }
            
            self.addBounceAnimationToView(annotationView!)
            return annotationView
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.lineWidth = 0.1
            return polygonView
        }
        return MKOverlayRenderer()
    }
    
    func addBounceAnimationToView(_ view: UIView)
    {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale") as CAKeyframeAnimation
        bounceAnimation.values = [0.05, 1.1, 0.9, 1]
        
        let timingFunctions = NSMutableArray(capacity: bounceAnimation.values!.count)
        
        for _ in 0 ..< bounceAnimation.values!.count {
            timingFunctions.add(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
        }
        bounceAnimation.timingFunctions = timingFunctions as NSArray as? [CAMediaTimingFunction]
        bounceAnimation.isRemovedOnCompletion = false
        
        view.layer.add(bounceAnimation, forKey: "bounce")
    }
    
    
    @objc func handleTap(gesRect: UITapGestureRecognizer)
    {
        
        let location = gesRect.location(in: mapView)
        coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        let locCoord = mapView.convert(location, toCoordinateFrom: mapView)
        print("Tapped at lat: \(locCoord.latitude) long: \(locCoord.longitude)")
        print("Tapped at: \(location)")
        
        let geoCoder = CLGeocoder()
        let CLlocation = CLLocation.init(latitude: locCoord.latitude, longitude: locCoord.longitude)
        
        geoCoder.reverseGeocodeLocation(CLlocation) { [weak self] (placemarks, error) in
            
            guard error == nil, let self = self else { return }
            
            if placemarks!.count > 0
            {
                
                let topResult = placemarks![0]
                let region: MKCoordinateRegion = self.mapView.region
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(placemark)
                
                guard placemark.countryCode == "US",
                    let state_Initials = placemark.administrativeArea?.lowercased() else
                {
                    self.showAlert(title: "NOT IN USA", message: "Please Tap at a location within the USA")
                    return
                }
                
                self.cvm.getData(from: state_Initials)
                self.cvm.loadedGraph = {
                    
                    DispatchQueue.main.async
                        {
                            self.showChart(for: state_Initials, with: self.cvm)
                    }
                    
                }
            }
        }
        
        
        // Add annotation:
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locCoord
    }
    
    
    /// Presents ChartViewController
    /// - Parameter vm: viewModel to pass into ChartViewController
    func showChart(for state: String, with vm: CovidViewModel)
    {
        self.fpc.hide(animated: true)
        {
            self.chartVC = ChartViewController(with: vm)
            self.fpc.set(contentViewController: self.chartVC)
            self.fpc.show(animated: true)
            {
                self.fpc.track(scrollView: self.chartVC.collectionView)
                self.setTitle(fromSelected: state)
            }
        }
    }
    
    func setTitle(fromSelected state: String = "USA")
    {
        let stateUppercase = state.uppercased()
        
        self.title = state == "USA" ? state : States.dict[stateUppercase]?.uppercased()
    }
    
}

extension MapViewController: FloatingPanelControllerDelegate
{
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout?
    {
        switch newCollection.verticalSizeClass {
        case .compact:
            fpc.surfaceView.borderWidth = 1.0 / traitCollection.displayScale
            fpc.surfaceView.borderColor = UIColor.black.withAlphaComponent(0.2)
            return PanelLandscapeLayout()
        default:
            fpc.surfaceView.borderWidth = 0.0
            fpc.surfaceView.borderColor = nil
            return nil
        }
    }
    
    func floatingPanelDidMove(_ vc: FloatingPanelController)
    {
        let y = vc.surfaceView.frame.origin.y
        let tipY = vc.originYOfSurface(for: .tip)
        if y > tipY - 44.0 {
            let progress = max(0.0, min((tipY  - y) / 44.0, 1.0))
            self.chartVC.collectionView.alpha = progress
        }
        debugPrint("NearbyPosition : ",vc.position)
    }
    
    
    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition)
    {
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .allowUserInteraction,
                       animations: {
                        if targetPosition == .tip {
                            self.chartVC.collectionView.alpha = 0.0
                        } else {
                            self.chartVC.collectionView.alpha = 1.0
                        }
        }, completion: nil)
    }
    
}

public class PanelLandscapeLayout: FloatingPanelLayout {
    
    public var initialPosition: FloatingPanelPosition
    {
        return .tip
    }
    
    public var supportedPositions: Set<FloatingPanelPosition>
    {
        return [.full, .tip]
    }
    
    public func insetFor(position: FloatingPanelPosition) -> CGFloat?
    {
        switch position {
        case .full: return 16.0
        case .tip: return 69.0
        default: return nil
        }
    }
    
    public func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint]
    {
        if #available(iOS 11.0, *) {
            return [
                surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8.0),
                surfaceView.widthAnchor.constraint(equalToConstant: 291),
            ]
        } else {
            return [
                surfaceView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0),
                surfaceView.widthAnchor.constraint(equalToConstant: 291),
            ]
        }
    }
    
    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat
    {
        return 0.0
    }
    
}
