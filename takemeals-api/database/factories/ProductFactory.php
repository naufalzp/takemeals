<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;


/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $faker = \Faker\Factory::create();
        $faker->addProvider(new \FakerRestaurant\Provider\en_US\Restaurant($faker));

        return [
            'partner_id' => 1,
            'name' => $faker->foodName(),
            'description' => fake()->text(),
            'type_food' => fake()->randomElement(['Makanan Berat', 'Minuman', 'Cemilan']),
            'price' => fake()->numberBetween(5000, 50000),
            'image' => fake()->imageUrl(640, 480, 'food', true),
            'stock' => fake()->numberBetween(1, 20),
            'expired' => fake()->numberBetween(1, 10),
        ];
    }
}
