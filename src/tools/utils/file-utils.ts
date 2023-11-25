import fs from 'fs';
import path from 'path';
import _ from 'lodash';

export default class FileUtils {

  static readAllFilesSync (dir: string, fileMatcher: (val: string) => boolean = () => true): Array<string> {
    return fs.readdirSync(dir).reduce((files: Array<string>, file) => {
      if (fs.statSync(path.join(dir, file)).isDirectory()) {
        return files.concat(FileUtils.readAllFilesSync(path.join(dir, file), fileMatcher));
      }
      else {
        return files.concat(fileMatcher(file) ? [path.join(dir, file)] : []);
      }
    }, []);
  }

  static parseFiles (rootDir: string, allowPatterns: Array<string>, blockPatterns: Array<string>, parser: (val: any) => any): Array<any> {
    const fileMatcher = (filePath: string) => {
      for (const pattern of blockPatterns) {
        if (filePath.endsWith(pattern)) {
          return false;
        }
      }
      for (const pattern of allowPatterns) {
        if (!filePath.endsWith(pattern)) {
          return false;
        }
      }
      return true;
    };

    const fileNames = FileUtils.readAllFilesSync(rootDir, fileMatcher);
    return fileNames.map((path) => {
      try {
        return JSON.parse(fs.readFileSync(path).toString());
      }
      catch (err) {
        console.error('Failed to parse', path, err);
        throw err;
      }
    }).flat().map(parser);
  }
}
