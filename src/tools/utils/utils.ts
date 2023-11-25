import crypto from 'crypto';

export default class Utils {
  static random_md5 (): string {
    const data = (Math.random() * new Date().getTime()) + "asdf" + (Math.random() * 1000000) + "fdsa" +(Math.random() * 1000000);
    return crypto.createHash('md5').update(data).digest('hex');
  }
}
