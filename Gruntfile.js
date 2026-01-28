module.exports = function(grunt) {

	grunt.loadNpmTasks("grunt-shell");
	grunt.loadNpmTasks("grunt-contrib-watch");
	grunt.loadNpmTasks("grunt-mkdir");
	grunt.loadNpmTasks("grunt-ftp-deploy");
	grunt.loadNpmTasks("grunt-contrib-connect");
    grunt.loadNpmTasks("grunt-text-replace");

	grunt.initConfig({
		connect: {
			server: {
				options: {
					port: 8080,
					base: "zbudowane/html",
					keepalive: true
				}
			}
		},
		"ftp-deploy": {
			build: {
				auth: {
					host: "ponadmurami.pl",
					port: 21,
					authKey: "key"
				},
				src: "zbudowane/html",
				dest: "/",
                forceVerbose: true
			}
		},	
		mkdir: {
			all: {
				options: {
					create: ["zbudowane"]
				}
			}
		},	
		watch: {
			html: {
				files: ["zrodla_pl/**/*.rst", "zrodla_en/**/*.rst"],
				tasks: ["mkdir", "shell:makeHtml"]
			},
			all: {
				files: ["zrodla_pl/**/*.rst", "zrodla_en/**/*.rst"],
				tasks: ["mkdir", "shell:makeRelease"]
			}
		},
		shell: {
			makeHtml: {
				command: "make html"
			},
			makeRelease: {
				command: "make release"
			}
		},
        replace: {
            pl: {
                src: ["zrodla_pl/**/*.rst"],
                overwrite: true,
                replacements: [{
                    from: / (w|W|i|I|z|Z|o|O|a|A|u|U) /g,
                    to: " $1~"
                }]
            }
        }
	});	
	
	grunt.task.registerTask("make", ["mkdir", "replace:pl", "shell:makeRelease"]);
	grunt.task.registerTask("deploy", ["ftp-deploy"]);
	grunt.task.registerTask("server", ["connect"]);
	grunt.registerTask("default", ["mkdir", "watch:html"]);
};
