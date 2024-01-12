<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;

class CartController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $carts = Cart::all();
        return response()->json(['data' => $carts]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required',
            'product_id' => 'required',
            'quantity' => 'required',
        ]);

        $cart = Cart::create($request->all());

        return response()->json(['message' => 'Cart item added successfully', 'data' => $cart], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $cart = Cart::findOrFail($id);
        return response()->json(['data' => $cart]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'quantity' => 'required',
        ]);

        $cart = Cart::findOrFail($id);
        $cart->update($request->all());

        return response()->json(['message' => 'Cart item updated successfully', 'data' => $cart]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $cart = Cart::findOrFail($id);
        $cart->delete();

        return response()->json(['message' => 'Cart item deleted successfully']);
    }
}
