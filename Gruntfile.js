'use strict';

module.exports = function (grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        jshint: {
            options: {
                jshintrc: true
            },
            files: ['Gruntfiles.js', 'examples/*.js']
        },

        jslint: {
            server: {
                src: ['Gruntfiles.js', 'examples/*.js'],
                directives: {
                    node: true
                }
            }
        },

        coffeelint: {
            files: ['xmpp.coffee']
        },

        coffee: {
            compile: {
                files: {
                    'xmpp.js': 'xmpp.coffee'
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-coffeelint');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-jslint');

    grunt.registerTask('default', ['jshint:files', 'jslint', 'coffeelint:files', 'coffee:compile']);
};
// vim: ts=4 sw=4 sts=4 et:
