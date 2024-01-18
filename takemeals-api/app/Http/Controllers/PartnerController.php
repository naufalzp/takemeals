<?php

namespace App\Http\Controllers;

use App\Models\Partner;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PartnerController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $partners = Partner::all();

        return response()->json([
            'success' => true,
            'data' => $partners,
        ], 200);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
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
            'store_name' => 'required',
            'address' => 'required',
            'city' => 'required',
            'province' => 'required',
            'open_at' => 'required',
            'close_at' => 'required',
            'latitude' => 'required',
            'longitude' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        $partner = Partner::create($request->all());

        $userUpdate = User::where('id', $request->user_id)->update([
            'is_partner' => true,
        ]);

        if (!$partner || !$userUpdate) {
            return response()->json([
                'success' => false,
                'message' => 'Partner creation failed',
            ], 500);
        }

        return response()->json([
            'success' => true,
            'message' => 'Partner created successfully',
            'data' => $partner,
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $partner = Partner::findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => $partner,
        ], 200);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $partner = Partner::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'user_id' => 'required',
            'store_name' => 'required',
            'address' => 'required',
            'city' => 'required',
            'province' => 'required',
            'open_at' => 'required',
            'close_at' => 'required',
            'latitude' => 'required',
            'longitude' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }

        $partner->update($request->all());

        return response()->json([
            'success' => true,
            'message' => 'Partner updated successfully',
            'data' => $partner,
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $partner = Partner::findOrFail($id);
        $partner->delete();

        return response()->json([
            'success' => true,
            'message' => 'Partner deleted successfully',
        ], 200);
    }
}
