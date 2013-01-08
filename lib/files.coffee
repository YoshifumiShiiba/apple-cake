
fs     = require 'fs'

class exports.Files

  constructor:(@dir, @ext)->
    if typeof @dir is "object"
      @parseOptions @dir

    @setDirectory @dir

    dir = @getDirectoryPath()
    @files = []
    @fileNames = []

    for f in fs.readdirSync @dir
      regExp = new RegExp "^(\\w+)\\.#{@ext}$"
      if f.match regExp
        @files.push "#{dir}#{RegExp.$1}.#{@ext}"
        @fileNames.push "#{RegExp.$1}"

  parseOptions: (options)->
    @ext = options.extention
    if options.directory
      @dir = options.directory
    else
      @dir = false

  setDirectory: (dir)->
    if not dir 
      dir = "."
    @dir = dir.replace /^(.*?)(\/*)$/, "$1"

  getDirectoryPath:()->
    if @dir
      return "#{@dir}/"
    return ""

  watch: (callback)->
    console.log "Watching for changes :"
    console.log "  #{file}" for file in @files

    dir = @getDirectoryPath()
    for file in @fileNames
      do (file)=>
        fs.watchFile "#{dir}#{file}.#{@ext}", (curr, prev) =>
          if +curr.mtime isnt +prev.mtime
            console.log "Saw change in #{dir}#{file}.#{@ext}"
            callback @dir, file, @ext

  build: (callback)->
    console.log "Build :"
    console.log "  #{file}" for file in @files

    for file in @fileNames
      do (file)=>
        callback @dir, file, @ext

