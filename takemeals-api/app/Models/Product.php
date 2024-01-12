<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'user_id',
        'name',
        'description',
        'type_food',
        'price',
        'stock',
        'expired',
    ];

    protected $dates = ['expired'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function carts()
    {
        return $this->belongsToMany(Cart::class);
    }

    public function histories()
    {
        return $this->hasMany(History::class);
    }
}
