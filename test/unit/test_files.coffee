
Files = require("../../lib/files").Files

exports.testFiles = 

  constructor:(test)->
    f = new Files "../test", "js"
    test.equal f.dir, "../test"
    test.equal f.files[0], "../test/run"
    test.equal f.fileNames[0], "run"
    test.done()

  parseOptions:(test)->
    f = new Files
      directory:"../test",
      extention:"js"
    test.equal f.dir, "../test"
    test.equal f.ext, "js"
    test.done()

  setDirectory:(test)->
    f = new Files "../test/", "js"
    test.equal f.dir, "../test"
    f = new Files "../test//", "js"
    test.equal f.dir, "../test"
    f = new Files "", "js"
    test.equal f.dir, "."
    test.done()

  getDirectoryPath:(test)->
    f = new Files "../test/", "js"
    test.equal f.getDirectoryPath(), "../test/"
    f = new Files "", "coffee"
    test.equal f.getDirectoryPath(), "./"
    test.done()

  watch:(test)->
    # TODO: check a updated file callback params
    test.done()

  build:(test)->
    # TODO: check a updated file callback params
    f = new Files "../test", "js"
    f.build (dir, file, ext)->
      test.equal dir, "../test"
      test.equal file, "run"
      test.equal ext, "js"
      test.done()

