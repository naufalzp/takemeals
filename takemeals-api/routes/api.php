<?php

use App\Http\Controllers\CartController;
use App\Http\Controllers\HistoryController;
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
});

Route::group(['prefix' => 'v1/products'], function () {
    Route::get('/', [ProductController::class, 'index'])->name('products.index');
    Route::get('/{id}', [ProductController::class, 'show'])->name('products.show');
    Route::post('/', [ProductController::class, 'store'])->name('products.store');
    Route::put('/{id}', [ProductController::class, 'update'])->name('products.update');
    Route::delete('/{id}', [ProductController::class, 'destroy'])->name('products.destroy');
})->middleware('auth:api');

Route::group(['prefix' => 'v1/carts'], function () {
    Route::get('/', [CartController::class, 'index'])->name('carts.index');
    Route::get('/{id}', [CartController::class, 'show'])->name('carts.show');
    Route::post('/', [CartController::class, 'store'])->name('carts.store');
    Route::put('/{id}', [CartController::class, 'update'])->name('carts.update');
    Route::delete('/{id}', [CartController::class, 'destroy'])->name('carts.destroy');
    Route::get('/{id}/edit', [CartController::class, 'edit'])->name('carts.edit');
    Route::get('/create', [CartController::class, 'create'])->name('carts.create');
})->middleware('auth:api');

Route::group(['prefix' => 'v1/histories'], function () {
    Route::get('/', [HistoryController::class, 'index'])->name('histories.index');
    Route::get('/{id}', [HistoryController::class, 'show'])->name('histories.show');
    Route::post('/', [HistoryController::class, 'store'])->name('histories.store');
    Route::put('/{id}', [HistoryController::class, 'update'])->name('histories.update');
    Route::delete('/{id}', [HistoryController::class, 'destroy'])->name('histories.destroy');
    Route::get('/{id}/edit', [HistoryController::class, 'edit'])->name('histories.edit');
    Route::get('/create', [HistoryController::class, 'create'])->name('histories.create');
})->middleware('auth:api');