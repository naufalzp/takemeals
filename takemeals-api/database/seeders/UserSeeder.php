<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::factory()->create([
            'name' => 'Test User Partner',
            'email' => 'nzp@mail.com',
            'password' => '12345678',
            'created_at' => now(),
            'updated_at' => now(),
            'phone' => '0889977665',
            'is_partner' => true,
        ]);

        User::factory()->create([
            'name' => 'Test User User',
            'email' => 'nzp@user.com',
            'password' => '12345678',
            'created_at' => now(),
            'updated_at' => now(),
            'phone' => '0843655346',
            'is_partner' => false,
        ]);
    }
}
