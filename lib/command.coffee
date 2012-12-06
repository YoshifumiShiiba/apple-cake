
{exec} = require 'child_process'

class exports.Command

  exec: (command, callback)->
    exec command, (err, stdout, stderr)=>
      if err
        console.log stderr
        callback false, err, stdout, stderr
      else
        callback true, err, stdout, stderr

