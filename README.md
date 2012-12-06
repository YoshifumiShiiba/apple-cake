#apple-cake
==========

apple-cake is a module for cake on node.js. for more simply.

##Install

    npm install -g apple-cake
    
apple-cake need a cake on coffee-script. if you has not it, type for.

    npm install -g coffee-script

##Using

###CoffeeScript to JS
Put file that name is "Cakefile" (no extension) on your Web application project, or node.js project. And edit for.

	ac = require 'apple-cake'
	
	# Create command object
	cmd = new ac.Command()

	# Create files object
	coffeeFiles = new ac.Files
  	  directory : "js"
  	  extention : "coffee"

	task 'watch', 'Watch source files and build changes', (data)->

  	  coffeeFiles.watch (dir, file, ext)->
        cmd.exec "coffee -c #{dir}/#{file}.coffee", (success)->
          if success
            console.log "Success build #{file}.js"

And run it. type for.

	cake watch

That example a CoffeeScript files watch to change the file, and compile to JS file on js direcotry. 

###CoffeeScript to minified JS and Sass to CSS
 
	# Need compiler.jar in Closure Compiler by Google
	# http://closure-compiler.googlecode.com/files/compiler-latest.zip
 
	ac = require 'apple-cake'
	cmd = new ac.Command()
 
    coffeeFiles = new ac.Files "js", "coffee" 
	sassFiles = new ac.Files "css", "sass" 
 
	coffee = (file)->
	  "coffee -c #{file}.coffee"
 
	closureCompiler = (file)->
	  gcc = "compiler.jar"
	  level = "SIMPLE_OPTIMIZATIONS"
	  "java -jar #{gcc} --compilation_level #{level} --js #{file}.js --js_output_file #{file}.min.js"

	sass = (file)->
	  "sass -C #{file}.sass:#{file}.css"

 
	task 'watch', 'Watch source files and build changes', (data)->
   
	  coffeeFiles.watch (dir, file, ext)->
	    # Everytime you can get file list from files object, example :
	    # console.log coffeeFiles.fileNames
	    cmd.exec coffee("#{dir}/#{file}"), (success)->
	      if success 
	        console.log "Success build #{file}.js"

	        # You can get more info from command result
	        cmd.exec closureCompiler("#{dir}/#{file}"), (success, err, stdout, stderr)->
	          if success 
	            console.log "Success build #{file}.min.js"
 
	  sassFiles.watch (dir, file, ext)->
	    cmd.exec sass("#{dir}/#{file}"), (success)->
	      if success 
	        console.log "Success build #{file}.css"

Are you OK?

Enjoy apple-cake and cake.
Thanks.
