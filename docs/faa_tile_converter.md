# FAA Tile Converter Integration Guide

This document details how to use and interact with the [FAATileConverter](https://github.com/VuNKhoi/FAATileConverter) pipeline for AviationMap, including technical details, workflow, and integration steps.

---

## What FAATileConverter Does
- **Automates FAA chart processing:** Downloads latest VFR Sectional, Terminal Area, and IFR Low/High charts.
- **Organizes charts:** Stores downloads in `downloads/sectional/`, `downloads/ifr_low/`, `downloads/ifr_high/`.
- **Converts GeoTIFFs to XYZ raster tiles:** Uses GDAL, handles paletted TIFFs automatically.
- **Uploads tiles to S3:** With cache-control headers for efficient client caching.
- **Notifies by email on completion.**
- **Includes E2E and unit tests for reliability.**
- **Provides S3 cleanup workflow.**

---

## Technical Workflow
1. **Download Step:**
   - Run `python scripts/download_faa_charts.py --check-current` to fetch new/updated charts only.
   - Charts are unzipped and stored in organized folders.
2. **Convert Step:**
   - Run `python scripts/convert_faa_charts.py` to convert all GeoTIFFs to tiles.
   - Handles paletted TIFFs, converts to RGBA as needed.
3. **Upload Step:**
   - Tiles are uploaded to S3 with `--cache-control "public, max-age=31536000, immutable"` for long-term caching.
   - Minimal E2E test skips cache-control for CI.
4. **Notification:**
   - Email sent on job completion (see workflow config).
5. **Testing:**
   - Run unit tests: `python scripts/test_faa_chart_conversion.py`, `python scripts/test_faa_chart_extraction.py`
   - E2E tests validate pipeline and S3 upload logic.
6. **Cleanup:**
   - Manual workflow deletes all objects in S3 test bucket.

---

## Integration Steps for AviationMap
1. **Set up S3 bucket:**
   - Ensure you have an AWS S3 bucket for tile hosting.
   - Configure credentials/secrets securely (never commit to repo).
2. **Configure FAATileConverter:**
   - Update S3 bucket details in workflow/scripts.
   - (Optional) Set up email notification.
3. **Run the pipeline:**
   - Use GitHub Actions for scheduled/manual runs, or run scripts locally for development.
   - Validate output tiles in S3.
4. **Update AviationMap overlay URLs:**
   - Point `BaseMapView` overlays to your S3 tile URLs (e.g., `https://your-bucket/sectional/{z}/{x}/{y}.png`).
   - Test overlays in the app for correct display and performance.
5. **Monitor and maintain:**
   - Use E2E/unit tests to ensure pipeline reliability.
   - Trigger S3 cleanup workflow as needed.

---

## Troubleshooting
- If conversion fails, check GDAL installation and TIFF format compatibility
- For S3 upload issues, verify credentials and bucket permissions
- For email notification errors, check workflow config and SMTP settings

## Updating FAA Chart Sources
- If FAA changes chart formats or URLs, update the download script and test conversion
- Monitor FAA notices for chart updates

## Support & Issues
- For pipeline support, open an issue at [FAATileConverter GitHub](https://github.com/VuNKhoi/FAATileConverter/issues)

## Example Usage (Local)
```bash
# Download charts (with current-check)
python scripts/download_faa_charts.py --check-current
# Convert all GeoTIFFs to tiles
python scripts/convert_faa_charts.py
# Run unit tests
python scripts/test_faa_chart_conversion.py
python scripts/test_faa_chart_extraction.py
```

---

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
