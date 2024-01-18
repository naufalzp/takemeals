<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Partner;

class PartnerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Create some partner records
        Partner::create([
            'user_id' => 1,
            'store_name' => 'Zhafif Store',
            'address' => 'Jl. Avidya, No. 10, Gunungpati, Semarang.',
            'city' => 'Semarang',
            'province' => 'Jawa Tengah',
            'open_at' => '08:00:00',
            'close_at' => '17:00:00',
            'latitude' => '-6.982619',
            'longitude' => '110.409687',
        ]);



        // Add more partner records as needed
    }
}
