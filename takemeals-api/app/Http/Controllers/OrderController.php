<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class OrderController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required',
            'product_id' => 'required',
            'quantity' => 'required',
            'total_price' => 'required',
            'payment_method' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        $order = Order::create(array_merge($request->all(), ['status' => 'pending']));

        $product = Product::findOrFail($request->product_id);

        if (!$order || !$product) {
            return response()->json([
                'success' => false,
                'message' => 'Order failed to create',
            ], 500);
        }


        $product->stock -= $request->quantity;
        $product->save();

        if ($product->stock == 0) {
            $product->delete();
        }


        return response()->json([
            'success' => true,
            'message' => 'Order created successfully',
            'data' => $order,
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $userId)
    {
        $user = User::findOrFail($userId);

        if (!$user->is_partner) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized',
            ], 401);
        }

        $orders = Order::where('user_id', $userId)->get();

        return response()->json([
            'success' => true,
            'data' => $orders,
        ], 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required',
            'product_id' => 'required',
            'quantity' => 'required',
            'total_price' => 'required',
            'status' => 'required',
            'payment_method' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        $order = Order::findOrFail($id);

        if (!$order) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found',
            ], 404);
        }

        if ($request->status == 'ready') {
            $order->update([
                'status' => 'ready',
            ]);
        } else if ($request->status == 'finished') {
            $order->update([
                'status' => 'finished',
            ]);
        } else if ($request->status == 'canceled') {
            $order->update([
                'status' => 'canceled',
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Status not found',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Order updated successfully',
            'data' => $order,
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $order = Order::findOrFail($id);
        $order->delete();

        return response()->json([
            'success' => true,
            'message' => 'Order deleted successfully',
        ], 200);
    }
}
