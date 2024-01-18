<?php

use App\Http\Controllers\OrderController;
use App\Http\Controllers\PartnerController;
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
        Route::get('/partner/{partnerId}', [ProductController::class, 'showByPartner'])->name('products.showByPartner');
        Route::post('/', [ProductController::class, 'store'])->name('products.store');
        Route::put('/{id}', [ProductController::class, 'update'])->name('products.update');
        Route::delete('/{id}', [ProductController::class, 'destroy'])->name('products.destroy');
    });

    // Partner
    Route::group(['prefix' => 'partners', 'middleware' => 'auth:api'], function () {
        Route::get('/', [PartnerController::class, 'index']);
        Route::get('/{id}', [PartnerController::class, 'show'])->name('partners.show');
        Route::post('/', [PartnerController::class, 'store'])->name('partners.store');
        Route::put('/{id}', [PartnerController::class, 'update'])->name('partners.update');
        Route::delete('/{id}', [PartnerController::class, 'destroy'])->name('partners.destroy');
    });

    // Order
    Route::group(['prefix' => 'orders', 'middleware' => 'auth:api'], function () {
        Route::get('/{userId}', [OrderController::class, 'show'])->name('orders.show');
        Route::post('/', [OrderController::class, 'store'])->name('orders.store');
        Route::put('/{id}', [OrderController::class, 'update'])->name('orders.update');
        Route::delete('/{id}', [OrderController::class, 'destroy'])->name('orders.destroy');
    });
});


