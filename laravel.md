# laravel  demo

## 服务提供者

    服务提供者用于为相关服务容器提供统一绑定场所

## 定义契约接口
 
    <?php
    
    namespace App\Contracts;
    
    interface TestContract
    {
        public function callMe($controller);
    }

## 定义服务类

    <?php
    
    namespace App\Services;
    
    use App\Contracts\TestContract;
    
    class TestService implements TestContract
    {
        public function callMe($controller)
        {
            dd('Call Me From TestServiceProvider In '.$controller);
        }
    }

## 创建服务提供者

    php artisan make:provider TestServiceProvider
    
编辑TestServiceProvider.php文件 
    
    <?php
    
    namespace App\Providers;
    
    use Illuminate\Support\ServiceProvider;
    use App\Services\TestService;
    
    class TestServiceProvider extends ServiceProvider
    {
        /**
         * Bootstrap the application services.
         *
         * @return void
         */
        public function boot()
        {
            //
        }
    
        /**
         * Register the application services.
         *
         * @return void
         * @author LaravelAcademy.org
         */
        public function register()
        {
            //使用singleton绑定单例
            $this->app->singleton('test',function(){
                return new TestService();
            });
    
            //使用bind绑定实例到接口以便依赖注入
            $this->app->bind('App\Contracts\TestContract',function(){
                return new TestService();
            });
        }
    }

## 注册服务提供者

    'providers' => [
    
        //其他服务提供者
    
        App\Providers\TestServiceProvider::class,
    ],
## 测试服务提供者
编辑TestController文件 

    <?php
    
    namespace App\Http\Controllers;
    
    use Illuminate\Http\Request;
    
    use App\Http\Requests;
    use App\Http\Controllers\Controller;
    
    use App;
    use App\Contracts\TestContract;
    
    class TestController extends Controller
    {
        //依赖注入
        public function __construct(TestContract $test){
            $this->test = $test;
        }
    
        /**
         * Display a listing of the resource.
         *
         * @return Response
         * @author LaravelAcademy.org
         */
        public function index()
        {
            // $test = App::make('test');
            // $test->callMe('TestController');
            $this->test->callMe('TestController');
        }
    
        ...//其他控制器动作
    }
    
## 路由功能
#### 简单路由
    闭包路由
    Route::get('hello', function () {
        return 'Hello, Welcome to LaravelAcademy.org';
    });
控制器路由

    Route::get('/user', 'UsersController@index');
响应多种 HTTP 请求路由

    Route::match(['get', 'post'], 'foo', function () {
        return 'This is a request from get or post';
    });

    Route::any('bar', function () {
        return 'This is a request from any HTTP verb';
    });
    
路由重定项
    
    Route::redirect('/here', '/there');
    Route::redirect('/here', '/there', 301);
    Route::permanentRedirect('/here', '/there');
    
路由重定项
     
    Route::view('/welcome', 'welcome');
    Route::view('/welcome', 'welcome', ['name' => 'title']);
    
路由参数
    
    Route::get('user/{id}', function ($id) {
        return 'User ' . $id;
    });
    Route::get('posts/{post}/comments/{comment}', function ($postId, $commentId) {
        return $postId . '-' . $commentId;
    });
     
    
#### 正则约束
    
    Route::get('user/{name}', function ($name) {
        // $name 必须是字母且不能为空
    })->where('name', '[A-Za-z]+');

    Route::get('user/{id}', function ($id) {
        // $id 必须是数字
    })->where('id', '[0-9]+');

    Route::get('user/{id}/{name}', function ($id, $name) {
        // 同时指定 id 和 name 的数据格式
    })->where(['id' => '[0-9]+', 'name' => '[a-z]+']);

##### 命名路由
    Route::get('user/profile', function () {
        // 通过路由名称生成 URL
        return 'my url: ' . route('profile');
    })->name('profile');
    
    Route::get('user/profile', 'UserController@showProfile')->name('profile');
    
    // 生成URL
    $url = route('profile');    
    
    Route::get('user/{id}/profile', function ($id) {
        return $url;
    })->name('profile');
    
    // 生成URL
    $url = route('profile', ['id' => 1]);
    
###### 路由分组
    * 中间件
        Route::middleware(['first', 'second'])->group(function () {
            Route::get('/', function () {
                // Uses first & second Middleware
            });
        });
    * 命名空间
        Route::namespace('Admin')->group(function () {
            // Controllers Within The "App\Http\Controllers\Admin" Namespace
        });
    * 子域名路由
        Route::domain('{account}.blog.dev')->group(function () {
            Route::get('user/{id}', function ($account, $id) {
                return 'This is ' . $account . ' page of User ' . $id;
            });
        });
    * 路由前缀
        Route::prefix('admin')->group(function () {
            Route::get('users', function () {
                // Matches The "/admin/users" URL
            });
        });
     * 路由名称前缀
        Route::name('admin.')->group(function () {
            Route::get('users', function () {
                // 新的路由名称为 "admin.users"...
            })->name('users');
        });
        
#### 路由模型绑定
    参数名（比如 {task}）来告知路由解析器需要从 Eloquent 记录中根据给定的资源 ID 去查询模型实例，并将查询结果作为参数传入
    
###### 隐式绑定
    * {task} 参数值作为模型主键 ID 进行 Eloquent 查询
  
    Route::get('task/{task}', function (\App\Models\Task $task) {
      dd($task); // 打印 $task 明细
    });
    
    * 自定义查询字段
    
    <?php

    namespace App\Models;

    use Illuminate\Database\Eloquent\Model;

    class Task extends Model
    {
        public function getRouteKeyName() {
            return 'name';  // 以任务名称作为路由模型绑定查询字段
        }
    }
    
###### 显式绑定
  在 App\Providers\RouteServiceProvider 的 boot() 方法中新增如下这段配置代码：
  
    public function boot()
    {
        // 显式路由模型绑定
        Route::model('task_model', Task::class);

        parent::boot();
    }
    
  访问包含 {task_model} 参数的路由时，路由解析器都会从请求 URL 中解析出模型 ID  
  
        Route::get('task/model/{task_model}', function (\App\Models\Task $task) {
            dd($task);
        });
        
 出于性能的考虑，建议在后台使用这种路由模型绑定
 
###### 频率限制
 第一个是次数上限，第二个是指定时间段（单位：分钟）：
 
    Route::middleware('throttle:60,1')->group(function () {
        Route::get('/user', function () {
            //
        });
    });
###### 路由缓存

    执行路由缓存命令：
    php artisan route:cache
    删除路由缓存
    php artisan route:clear
    注意：缓存只能用于控制器路由，不能用于闭包路由
    
### 控制器
    Route::get('user/{id}', 'UserController@show');
    
    php artisan make:controller UserController 
    
    控制器添加一个 show 方法
    <?php

    namespace App\Http\Controllers;

    use App\User;
    use Illuminate\Http\Request;

    class UserController extends Controller
    {
        /**
         * 为指定用户显示详情
         *
         * @param int $id
         * @return Response
         * @author LaravelAcademy.org
         */
        public function show($id)
        {
            return view('user.profile', ['user' => User::findOrFail($id)]);
        }
    }
    
    
 #### 控制器中间件
 
        $this->middleware('auth')->only('show'); // 只对该方法生效
        $this->middleware('auth')->except('show');  // 对该方法以外的方法生效
    
   
#### 资源控制器

    php artisan make:controller PostController --resource
    
    Route::resource('posts', 'PostController');
    Route::resources([
        'photos' => 'PhotoController',
        'posts' => 'PostController'
    ]);
    
#### 指定资源模型
    php artisan make:controller PostController --resource --model=Post
    
    路由处理的动作子集
    Route::resource('post', 'PostController', ['only' => 
        ['index', 'show']
    ]);

    Route::resource('post', 'PostController', ['except' => 
        ['create', 'store', 'update', 'destroy']
    ]);
    
    API 资源路由
    Route::apiResources([
        'posts' => 'PostController',
        'photos' => 'PhotoController'
    ]);

    php artisan make:controller API/PostController --api
    
#### 方法注入
    * 构造函数注入
    <?php

    namespace App\Http\Controllers;

    use Illuminate\Http\Request;

    class UserController extends Controller
    {
        /**
         * 存储新用户
         *
         * @param Request $request
         * @return Response
         */
        public function store(Request $request)
        {
            $name = $request->name;

            //
        }
    }
    
    * 参数注入：
    Route::put('user/{id}', 'UserController@update');
    
    <?php

    namespace App\Http\Controllers;

    use Illuminate\Http\Request;

    class UserController extends Controller
    {
        /**
         * 更新指定用户
         *
         * @param Request $request
         * @param int $id
         * @return Response
         * @translator http://laravelacademy.org
         */
        public function update(Request $request, $id)
        {
            //
        }
    }
    
## 模型

生成模型类指令： php artisan make:model Models/Flight
    
 表名设置
 
    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 关联到模型的数据表
         *
         * @var string
         */
        protected $table = 'my_flights';
    }
    
 时间戳
 
    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 表明模型是否应该被打上时间戳
         *
         * @var bool
         */
        public $timestamps = false;
    }
    
数据库连接

     <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * The connection name for the model.
         *
         * @var string
         */
        protected $connection = 'connection-name';
    }
    
黑名单属性-$guarded 属性包含你不想被赋值的属性数组，$fillable是白名单

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 不能被批量赋值的属性
         *
         * @var array
         */
        protected $guarded = ['price'];
    }
