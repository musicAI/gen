
module.exports = function(grunt){
    grunt.initConfig({
        coffee: {
            Parser: {
                options:{
                    sourceMap: true
                },
                files: {
                    'coffee/ScoreObj.js': ['coffee/MG_Parser/*.coffee']
                }
            },
            Generator: {
                options:{
                    sourceMap: true
                },
                files: {
                    'coffee/Generator.js': ['coffee/MG_Generator/*.coffee']

                }

            },
            Player: {
                options:{
                    sourceMap: true
                },
                files: {
                    'coffee/Player.js': ['coffee/MG_Player/*.coffee']
                }

            },
            Renderer: {
                options:{
                    sourceMap: true
                },
                files: {
                    'coffee/ScoreRenderer.js': ['coffee/MG_Renderer/*.coffee']
                }
            },
            multiples: {
                expand: true,
                flatten: true,
                src: ['coffee/*.coffee'],
                dest: 'coffee/',
                ext: '.js'
            }

        },
        pug: {
            options: {
                client: false,
                pretty: true
            },
            app: {
                src: 'view/index.pug',
                dest: './app.html',
                options:{
                    data: grunt.file.readJSON('view/scripts_app.json')
                }
            },
            web: {
                src: 'view/index.pug',
                dest: './index.html',
                options:{
                    data: grunt.file.readJSON('view/scripts_web.json')
                }
            }
        },
        jison: {
            options: { moduleType: "commonjs"},
            score: {
                options: { moduleName: "score_parser" },
                files: [{src: 'coffee/MG_Parser/score.jison', dest: 'coffee/score_parser.js'}]
            },
            schema: {
                options: { moduleName: "schema_parser" },
                files: [{src: 'coffee/MG_Parser/schema.jison', dest: 'coffee/schema_parser.js'}]
            }
        },
        concat: {
            options: {
                separator: ';'
            },
            gen: {
                src: ['coffee/score_parser.js', 'coffee/schema_parser.js', 'coffee/musical.js', 'coffee/*.js', 'coffee/appMG.js', 'js/gen.js'],
                dest: 'js/gen-build.js'
            }
        },
        uglify: {
            web:{
                files: {
                    'js/gen-build.js': ['coffee/score_parser.js', 'coffee/schema_parser.js', 'coffee/musical.js', 'coffee/*.js', 'coffee/appMG.js', 'js/gen.js']
                }
            }
        }
    });
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-pug');
    grunt.loadNpmTasks('grunt-jison');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.registerTask('default', ['coffee:Parser', 'coffee:Generator', 'coffee:Renderer', 'coffee:Player', 'coffee:multiples', 'jison:score', 'jison:schema']);
    grunt.registerTask('web', ['pug:web', 'uglify:web']);
    grunt.registerTask('app', ['pug:app']);

}