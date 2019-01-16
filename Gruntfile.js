
module.exports = function(grunt){
    var coffeeTargets = function(pre){
        return ['score_parser', 'schema_parser', 'musical', '*', 'appMG'].map(function(e){
            return pre + '/' + e + '.js';
        });
    };

    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),
        
        coffee: {
            Parser: {
                options:{
                    sourceMap: true
                },
                files: {
                    'build/ScoreObj.js': ['coffee/MG_Parser/*.coffee']
                }
            },
            Generator: {
                options:{
                    sourceMap: true
                },
                files: {
                    'build/Generator.js': ['coffee/MG_Generator/*.coffee']

                }

            },
            Player: {
                options:{
                    sourceMap: true
                },
                files: {
                    'build/Player.js': ['coffee/MG_Player/*.coffee']
                }

            },
            Renderer: {
                options:{
                    sourceMap: true
                },
                files: {
                    'build/ScoreRenderer.js': ['coffee/MG_Renderer/*.coffee']
                }
            },
            multiples: {
                expand: true,
                flatten: true,
                src: ['coffee/*.coffee'],
                dest: 'build/',
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
                files: [{src: 'coffee/MG_Parser/score.jison', dest: 'build/score_parser.js'}]
            },
            schema: {
                options: { moduleName: "schema_parser" },
                files: [{src: 'coffee/MG_Parser/schema.jison', dest: 'build/schema_parser.js'}]
            }
        },
        concat: {
            options: {
                separator: ';'
            },
            gen: {
                src: coffeeTargets('build').concat(['js/gen.js']),
                dest: 'js/gen-build.js'
            }
        },
        uglify: {
            web:{
                files: {
                    'js/gen-build.js': coffeeTargets('build').concat(['js/gen.js'])
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