module.exports = function(grunt) {

	grunt.loadNpmTasks("grunt-shell");
	grunt.loadNpmTasks("grunt-contrib-watch");
	grunt.loadNpmTasks("grunt-contrib-copy");
	grunt.loadNpmTasks("grunt-mkdir");
	
	grunt.initConfig({
		mkdir: {
			all: {
				options: {
					create: ['zbudowane']
				}
			}
		},	
		copy: {
			main: {
				files: [
				  {expand: false, src: ['zrodla/.htaccess'], dest: 'zbudowane/html/.htaccess'},
				  {expand: false, src: ['zbudowane/latex/konspekty.pdf'], dest: 'zbudowane/html/konspekty.pdf'},
				  {expand: false, src: ['zbudowane/epub/konspekty.epub'], dest: 'zbudowane/html/konspekty.epub'},
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
			makeHtml: {
				command: "make html"
			},
			makeAll: {
				command: [
					"make clean", 
					"make html", 
					"make latexpdf", 
					"make epub"
				].join(" && ")
			}
		}
	});	
	
	grunt.task.registerTask("make", ["mkdir", "shell:makeAll", "copy:main"]);
	grunt.registerTask("default", ["mkdir", "watch:html"]);
};