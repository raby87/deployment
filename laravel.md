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
