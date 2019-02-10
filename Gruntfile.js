'use strict';

module.exports = function(grunt) {
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  grunt.initConfig({
    clean: {
      build: ['build/']
    },

    coffee: {
      compile_library: {
        expand: true,
        cwd: "src/library",
        src: ['**/*.coffee'],
        dest: 'lib',
        ext: '.js'
      },
      compile_tools: {
        expand: true,
        cwd: "src/tools",
        src: ['**/*.coffee'],
        dest: 'build',
        ext: '.js'
      }
    },

    run: {
      options: {
        failOnError: true
      },
      audit: {
        exec: 'node build/audit.js assets'
      },
      export_languages: {
        exec: 'node build/languages-export.js assets translations --type=' + (grunt.option('type') || '')
      },
      import_languages: {
        exec: 'node build/languages-import.js assets translations --type=' + (grunt.option('type') || '')
      }
    }
  });

  grunt.registerTask('build', ['coffee:compile_library', 'coffee:compile_tools']);
  grunt.registerTask('audit', ['build', 'run:audit']);

  grunt.registerTask('export', ['build', 'run:export_languages']);
  grunt.registerTask('import', ['build', 'run:import_languages']);

  grunt.registerTask('default', ['clean', 'build', 'audit']);
}
