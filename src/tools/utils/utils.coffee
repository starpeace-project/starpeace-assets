crypto = require('crypto')
fs = require('fs')
_ = require('lodash')
path = require('path')


exports = module.exports = class Utils
  @random_md5: () ->
    data = (Math.random() * new Date().getTime()) + "asdf" + (Math.random() * 1000000) + "fdsa" +(Math.random() * 1000000)
    crypto.createHash('md5').update(data).digest('hex')
