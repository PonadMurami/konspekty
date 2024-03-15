module.exports = function(grunt) {

	grunt.loadNpmTasks("grunt-shell");
	grunt.loadNpmTasks("grunt-contrib-watch");
	grunt.loadNpmTasks("grunt-contrib-copy");
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
		copy: {
			main: {
				files: [
				  {expand: false, src: ["zrodla/.htaccess"], dest: "zbudowane/html/.htaccess"},
				  {expand: false, src: ["zbudowane/latex/konspekty.pdf"], dest: "zbudowane/html/konspekty.pdf"},
				  {expand: false, src: ["zbudowane/epub/konspekty.epub"], dest: "zbudowane/html/konspekty.epub"},
				]
			}
		},
		watch: {
			html: {
				files: ["zrodla/**/*.rst"],
				tasks: ["mkdir", "shell:makeHtml"]
			},
			all: {
				files: ["zrodla/**/*.rst"],
				tasks: ["mkdir", "shell:makeAll", "copy:main"]
			}
		},
		shell: {
            makeMobi: {
                command: "/opt/calibre/ebook-convert zbudowane/html/konspekty.epub zbudowane/html/konspekty.mobi"
            },
            makeDocx: {
                command: "pandoc -o ./zbudowane/html/konspekty.docx ./zbudowane/html/konspekty.epub"
            },
			makeHtml: {
				command: "make html"
			},
			makeAll: {
				command: [
					"make clean", 
					"make html", 
                    "make singlehtml",
					"make latexpdf", 
					"make epub"
				].join(" && ")
			}
		},
        replace: {
            rst: {
                src: ["zrodla/**/*.rst"],
                overwrite: true,
                replacements: [{
                    from: / (w|W|i|I|z|Z|o|O|a|A|u|U) /g,
                    to: " $1~"
                }]
            }
        }
	});	
	
	grunt.task.registerTask("make", ["mkdir", "replace", "shell:makeAll", "copy:main", "shell:makeMobi", "shell:makeDocx"]);
	grunt.task.registerTask("deploy", ["ftp-deploy"]);
	grunt.task.registerTask("server", ["connect"]);
	grunt.registerTask("default", ["mkdir", "watch:html"]);
};
