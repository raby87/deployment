//1、nodeJs环境
//2.npm install -g grunt-cli

/*
{
  "name": "demo",
  "file": "zepto",  //zepto文件
  "version": "0.1.0",
  "description": "demo",
  "license": "MIT",
  "devDependencies": {
    "grunt": "~0.4.1",
    "grunt-contrib-jshint": "~0.6.3",
    "grunt-contrib-uglify": "~0.2.1",
    "grunt-contrib-requirejs": "~0.4.1",
    "grunt-contrib-copy": "~0.4.1",
    "grunt-contrib-clean": "~0.5.0",
    "grunt-strip": "~0.2.1"
  },
  "dependencies": {
    "express": "3.x"
  }
}
*/
/******************************************Gruntfile.js**************************************************************/
//第一步是配置任务，即grunt.initConfig({});第二步是加载任务插件;第三步注册可执行的任务命令。
//① 读取package信息
//② 插件加载、注册任务，运行任务（grunt对外的接口全部写在这里面）
module.exports = function (grunt) {
  //一。 配置任务
  grunt.initConfig({
    //这里的 grunt.file.readJSON就会将我们的配置文件读出，并且转换为json对象

    //然后我们在后面的地方就可以采用pkg.XXX的方式访问其中的数据了
    //值得注意的是这里使用的是underscore模板引擎，所以你在这里可以写很多东西
    pkg: grunt.file.readJSON('package.json'),
    
    //① 在src中找到zepto进行压缩（具体名字在package中找到）
    //② 找到dest目录，没有就新建，然后将压缩文件搞进去
    uglify: {
      options: {
        banner: '/*! <%= pkg.file %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: 'src/<%=pkg.file %>.js',
        dest: 'dest/<%= pkg.file %>.min.js'
      }
    }
  });
  //二。 加载任务插件
  grunt.loadNpmTasks('grunt-contrib-uglify');
  //三。 注册可执行的任务命令
  grunt.registerTask('default', ['uglify']);
}
