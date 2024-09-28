import fs from 'fs';
import path from 'path';
import { Jimp, intToRGBA, rgbaToInt } from 'jimp';


async function fixDirectory (directory: string): Promise<void> {
  const files = fs.readdirSync(directory);
  for (const file of files) {
    if (file.endsWith('.bmp')) {
      const bitmap = await Jimp.read(path.join(directory, file));

      const png = new Jimp({
        width: bitmap.bitmap.width,
        height: bitmap.bitmap.height
      });

      for (let y = 0; y < bitmap.bitmap.height; y++) {
        for (let x = 0; x < bitmap.bitmap.width; x++) {
          const pixel = bitmap.getPixelColor(x, y);
          const color = intToRGBA(pixel);
          if (!color.r && !color.g && !color.b) {
            png.setPixelColor(rgbaToInt(0, 0, 0, 0), x, y);
          }
          else {
            png.setPixelColor(rgbaToInt(color.r, color.g, color.b, 255), x, y);
          }
        }
      }

      png.write(`${path.join(directory, file.replace('.bmp', ''))}.png`);
    }
  }

}

fixDirectory('assets/tracks/images')
  .then(() => console.log('Done'));

