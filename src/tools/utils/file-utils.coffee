fs = require('fs')
_ = require('lodash')
path = require('path')

exports = module.exports = class FileUtils

  @read_all_files_sync: (dir, file_matcher=true) ->
    fs.readdirSync(dir).reduce((files, file) ->
      if fs.statSync(path.join(dir, file)).isDirectory()
        files.concat(FileUtils.read_all_files_sync(path.join(dir, file), file_matcher))
      else
        file_matches = if _.isFunction(file_matcher) then file_matcher(file) else file_matcher
        files.concat(if file_matches then path.join(dir, file) else [])
    , [])

  @parse_files: (root_dir, whitelist_patterns, blacklist_patterns, json_parser) ->
    file_matcher = (file_path) ->
      for pattern in blacklist_patterns
        return false if file_path.endsWith(pattern)
      for pattern in whitelist_patterns
        return false unless file_path.endsWith(pattern)
      true

    _.flatten(_.map(FileUtils.read_all_files_sync(root_dir, file_matcher), (path) -> _.map(JSON.parse(fs.readFileSync(path)), json_parser)))
