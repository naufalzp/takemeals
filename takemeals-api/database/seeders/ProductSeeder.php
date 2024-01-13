<?php

namespace Database\Seeders;

use App\Models\Product;
use Database\Factories\ProductFactory;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{

    protected $model = Product::class;
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Product::factory()
            ->count(10)
            ->create();
    }
}
