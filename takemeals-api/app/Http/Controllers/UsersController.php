<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Exception;
use Illuminate\Support\Facades\Validator;

class UsersController extends Controller
{
    public function login()
    {
        if (Auth::attempt(['email' => request('email'), 'password' => request('password')])) {
            /** @var \App\Models\User $user **/
            $user = Auth::user();
            $success['token'] = $user->createToken('appToken')->accessToken;
            return response()->json([
                'success' => true,
                'token' => $success,
                'user' => $user,
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Invalid Email or Password',
            ], 401);
        }
    }

    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:8'],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => $validator->errors(),
            ], 401);
        }

        try {
            $input = $request->all();
            $input['password'] = bcrypt($input['password']);
            $user = User::create($input);
            $success['token'] = $user->createToken('appToken')->accessToken;

            return response()->json([
                'success' => true,
                'token' => $success,
                'user' => $user
            ], 201);

        } catch (Exception $e) {
            $response = ['status' => 500, 'message' => $e];
            return response()->json($response);
        }
    }

    public function logout(Request $request)
    {
        if (Auth::user()) {
            $user = Auth::user()->token();
            $user->revoke();
            return response()->json([
                'success' => true,
                'message' => 'Logout successfully',
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Unable to Logout',
            ], 400);
        }
    }
}
