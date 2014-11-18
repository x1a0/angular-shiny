module.exports = (grunt) ->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig {
    pkg: grunt.file.readJSON "package.json"
    bower: grunt.file.readJSON "bower.json"

    dir:
      src:  "src"
      dist: "dist"

    files:
      src: "<%= dir.src %>/*.coffee"

    coffee:
      compile:
        files:
          "<%= pkg.main %>": ["<%= files.src %>"]

    uglify:
      build:
        src: "<%= pkg.main %>"
        dest: "<%= pkg.minified %>"

    watch:
      coffee:
        files: ["<%= files.src %>"]
        tasks: "coffee"

    clean: ["<%= dir.dist %>"]

    bump:
      options:
        files: ["package.json", "bower.json"]
        updateConfigs: ["pkg", "bower"]
        commit: yes
        commitMessage: "Release v%VERSION%"
        commitFiles: ["-a"]
        createTag: yes
        tagName: "v%VERSION%"
        tagMessage: "Version %VERSION%"
        push: no
        pushTo: "upstream"
        gitDescribeOptions: "--tags --always --abbrev=1 --dirty=-d"

  }

  grunt.registerTask "build", ["clean", "coffee", "uglify"]
  grunt.registerTask "default", ["clean", "coffee", "watch"]

  # usage: grunt release[:major|:minor|:patch]
  grunt.registerTask "release", "Release a new version", (target) ->
    target ?= "patch"
    grunt.task.run "bump-only:#{target}", "build", "bump-commit"
