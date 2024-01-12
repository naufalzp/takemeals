<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $products = Product::all();
        return response()->json(['data' => $products]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required',
            'name' => 'required',
            'description' => 'required',
            'type_food' => 'required',
            'price' => 'required',
            'stock' => 'required',
            'expired' => 'required',
        ]);

        $product = Product::create($request->all());

        return response()->json(['message' => 'Product created successfully', 'data' => $product], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $product = Product::findOrFail($id);
        return response()->json(['data' => $product]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'user_id' => 'required',
            'name' => 'required',
            'description' => 'required',
            'type_food' => 'required',
            'price' => 'required',
            'stock' => 'required',
            'expired' => 'required',
        ]);

        $product = Product::findOrFail($id);
        $product->update($request->all());

        return response()->json(['message' => 'Product updated successfully', 'data' => $product]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $product = Product::findOrFail($id);
        $product->delete();

        return response()->json(['message' => 'Product deleted successfully']);
    }
}
