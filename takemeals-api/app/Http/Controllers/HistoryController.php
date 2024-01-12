<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\History;

class HistoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // all histories
        $histories = History::all();
        return response()->json(['data' => $histories]);
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

        $history = History::create($request->all());

        return response()->json(['message' => 'History record added successfullyy', 'data' => $history], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $history = History::findOrFail($id);
        return response()->json(['data' => $history]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'quantity' => 'required',
        ]);

        $history = History::findOrFail($id);
        $history->update($request->all());

        return response()->json(['message' => 'History record updated successfully', 'data' => $history]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $history = History::findOrFail($id);
        $history->delete();

        return response()->json(['message' => 'History record deleted successfully']);
    }
}
