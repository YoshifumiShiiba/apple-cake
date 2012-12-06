
Command = require("../../lib/command").Command

exports.testCommand = 
  error:(test)->
    cmd = new Command()
    cmd.exec "dummycommand____", (success)->
      test.ok not success
      test.done()

  success:(test)->
    cmd = new Command()
    cmd.exec "ls /", (success)->
      test.ok success
      test.done()

