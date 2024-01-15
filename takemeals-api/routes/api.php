<?php

use App\Http\Controllers\OrderController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\UsersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::group(['prefix' => 'v1'], function () {
    Route::post('login', [UsersController::class, 'login']);
    Route::post('register', [UsersController::class, 'register']);
    Route::post('logout', [UsersController::class, 'logout'])->middleware('auth:api');

    // Product
    Route::group(['prefix' => 'products', 'middleware' => 'auth:api'], function () {
        Route::get('/', [ProductController::class, 'index']);
        Route::get('/{id}', [ProductController::class, 'show'])->name('products.show');
        Route::get('/user/{userId}', [ProductController::class, 'showByUser'])->name('products.showByUser');
        Route::post('/', [ProductController::class, 'store'])->name('products.store');
        Route::put('/{id}', [ProductController::class, 'update'])->name('products.update');
        Route::delete('/{id}', [ProductController::class, 'destroy'])->name('products.destroy');
    });

    // Order
    Route::group(['prefix' => 'orders', 'middleware' => 'auth:api'], function () {
        Route::get('/{userId}', [OrderController::class, 'show'])->name('orders.show');
        Route::post('/', [OrderController::class, 'store'])->name('orders.store');
        Route::put('/{id}', [OrderController::class, 'update'])->name('orders.update');
    });
});


