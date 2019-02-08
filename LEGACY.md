
# Legacy Assets

Changes to legacy assets, including removal from gameplay (moved to ```/legacy/``` folder), explained below:

## Land
* *all* - refactor - renamed land image files to strict format
* border.255.ini - bug fix - changed MapColor to 0
* land.0.ini - bug fix - flipped MapColor endian value (4358782 or #42827E to 8290882 or #7E8242)
* border.bmp - refactor - renamed to land.255.border0.bmp
* border1.bmp - refactor - renamed to land.255.border1.bmp
* special images - refactor - renamed to tree.<zone>.<variant>.bmp

## Maps
* Fraternite - renamed - renamed assets to remove special character (�)
* Liberte - removed - duplicate of Zyrane assets (same problems)
* StarpeaceU - removed - duplicate of Zyrane assets (same problems)
* Zyrane - removed - missing almost all matching land tiles (117/130)
