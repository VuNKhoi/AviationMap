# FAA Chart Tiling & Hosting Pipeline

To support sectional, IFR low, and IFR high overlays:

1. Download FAA charts (sectional, IFR low, IFR high) in GeoTIFF or high-res image format.
2. Use [gdal2tiles](https://gdal.org/programs/gdal2tiles.html) or [MapTiler](https://www.maptiler.com/) to convert each chart to XYZ raster tiles:
   - Example: `gdal2tiles.py -z 4-12 input.tif output_folder/`
3. Organize output as `/sectional/{z}/{x}/{y}.png`, `/ifr_low/{z}/{x}/{y}.png`, `/ifr_high/{z}/{x}/{y}.png`.
4. Host tiles on a static server, S3, Cloudflare R2, or locally for development.
5. Update your `BaseMapView` overlay URLs to point to your tile server.

---

# BaseMapView Usage

```
import 'package:aviationmap/features/map/widgets/base_map_view.dart';

// Sectional overlay
BaseMapView(overlayType: MapOverlayType.sectional);

// IFR Low overlay
BaseMapView(overlayType: MapOverlayType.ifrLow);

// IFR High overlay
BaseMapView(overlayType: MapOverlayType.ifrHigh);
```

- The widget will show the selected overlay and, by default, the user's current GPS position.
- Extend the widget to add more overlays (airspace, NOTAMs) as needed.
