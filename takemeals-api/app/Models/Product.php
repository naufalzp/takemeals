<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use HasFactory, HasFactory, SoftDeletes;

    protected $fillable = [
        'partner_id',
        'name',
        'description',
        'type_food',
        'price',
        'image',
        'stock',
        'expired',
    ];

    protected $dates = ['expired'];

    public function partner()
    {
        return $this->belongsTo(Partner::class);
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }
}
