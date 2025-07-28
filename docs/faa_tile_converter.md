
# FAA Tile Converter Integration Guide

This guide explains how the [FAATileConverter](https://github.com/VuNKhoi/FAATileConverter) pipeline powers AviationMap’s FAA chart overlays.

## What the Pipeline Does
- Downloads latest FAA charts (VFR Sectional, Terminal Area, IFR Low/High)
- Converts GeoTIFFs to XYZ raster tiles using GDAL
- Uploads tiles to S3 with long-term cache headers
- Maintains metadata (e.g., faa_chart_log.json) for versioning
- Includes E2E/unit tests and S3 cleanup workflow

## Workflow
1. **Download:**
   - `python scripts/download_faa_charts.py --check-current` (fetches new/updated charts)
2. **Convert:**
   - `python scripts/convert_faa_charts.py` (GeoTIFF → XYZ tiles)
3. **Upload:**
   - Tiles uploaded to S3 with proper cache-control
4. **Test:**
   - Run unit/E2E tests to validate conversion and upload
5. **Cleanup:**
   - Manual workflow deletes S3 test bucket objects

## Integrating with AviationMap
1. **Set up S3 bucket** for tile hosting (secure credentials, never commit secrets)
2. **Configure FAATileConverter** with your S3 details
3. **Run the pipeline** (GitHub Actions or local)
4. **Point AviationMap overlays** to your S3 tile URLs (e.g., `https://your-bucket/sectional/{z}/{x}/{y}.png`)
5. **Test overlays** in the app for display and performance
6. **Monitor and maintain** (use tests, update scripts as FAA changes)

## Troubleshooting
- Check GDAL install and TIFF compatibility for conversion errors
- Verify S3 credentials and permissions for upload issues
- Update scripts if FAA changes chart formats/URLs

## Support
- Open issues at [FAATileConverter GitHub](https://github.com/VuNKhoi/FAATileConverter/issues)

## Example Usage
```bash
# Download charts
python scripts/download_faa_charts.py --check-current
# Convert to tiles
python scripts/convert_faa_charts.py
# Run tests
python scripts/test_faa_chart_conversion.py
python scripts/test_faa_chart_extraction.py
```

## Notes & Recommendations
- Only main VFR Sectional, Terminal Area, and IFR Low/High charts are processed by default.
- Other chart types (Helicopter, Grand Canyon, Caribbean, etc.) are skipped; see scripts for TODOs if you want to expand.
- All processed chart metadata is stored in `scripts/metadata/faa_chart_log.json` for current-check logic.
- Always keep secrets and credentials out of version control.
- Validate tile output and caching in AviationMap after each pipeline run.

---

## Is This Good Enough?
- The FAATileConverter pipeline is robust, automated, and well-tested for AviationMap’s needs.
- It supports scheduled updates, efficient caching, and easy integration with your app.
- If you need more chart types or custom logic, extend the Python scripts as needed.
- For most aviation mapping use cases, this workflow is sufficient and production-ready.
